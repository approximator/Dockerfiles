#!/bin/bash

: ${PUSH_TO_DOCKER_HUB:=true}

if $PUSH_TO_DOCKER_HUB ; then
    DOCKER_EMAIL=${DOCKER_EMAIL:?}
    DOCKER_USERNAME=${DOCKER_USERNAME:?}
    DOCKER_PASSWORD=${DOCKER_PASSWORD:?}
fi

SCRIPT_DIR=$(cd $(dirname $0) && pwd)

images=( "$@" )

function is_the_same_as_latest {
    local FILE=$1
    if [ "$FILE" = "Dockerfile" ]; then
        return 1
    fi
    output=$(sha256sum $FILE)
    hash_current=${output:0:64}
    output=$(sha256sum Dockerfile)
    hash_latest=${output:0:64}
    if [ "$hash_current" = "$hash_latest" ]; then
        return 0
    fi
    return 1
}

function build {
    local FILE=$1
    local NAME=$2
    local VERSION=$3
    echo ""
    echo ""
    echo "================================================================="
    echo "Building image $NAME:$VERSION ($FILE)"

    is_the_same_as_latest $FILE
    if [ $? -eq 0 ]; then
        echo "$FILE is the same as latest. Just tag and push."
        docker tag "approximator/$image:latest" "approximator/$image:$VERSION"
        return $?
    fi

    COMMIT_HASH=`git log -1 --format=%H "$FILE"`
    echo "Building approximator/$image:$VERSION (Commit: $COMMIT_HASH)..."
    docker build --build-arg VCS_REF=$COMMIT_HASH --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` -f $FILE -t approximator/$image:$VERSION .. &> /tmp/dockerbuild_$image.$VERSION.txt &
    pid=$!
    while ps -p $pid >/dev/null
    do
        echo -n "."
        sleep 10
    done
    wait $pid

    return $?
}

failed=()

for image in "${images[@]}"; do
    cd $SCRIPT_DIR/$image
    docker_files=("Dockerfile" $(find . -iname 'Dockerfile_*' -printf '%P\n'))
    # echo $files
    for docker_file in "${docker_files[@]}"; do
        version=${docker_file#*_}
        if [ "$version" = "Dockerfile" ];then version="latest"; fi

        build $docker_file $image $version

        if [ $? -ne 0 ]; then
            echo "Error building $image"
            failed+=("$image:$version")
            continue
        fi

        if $PUSH_TO_DOCKER_HUB ; then
            docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
            docker push "approximator/$image:$version"
        fi
    done

    if [ ! -z "$WEBHOOK_URL" ]; then
        http post $WEBHOOK_URL -v
    fi
done

echo ""
echo ""
if [ -z "$failed" ]; then
    echo "Done :)"
    exit 0
else
    echo "==================== Errors ===================="
    for build in "${failed[@]}"; do
        echo $build
    done
    exit 1
fi
