#!/bin/bash

image="qt"
VERSION="build_5.10.1"

FILE=build_Dockerfile_5.10.1
COMMIT_HASH=`git log -1 --format=%H "$FILE"`
echo "Building approximator/$image:$VERSION (Commit: $COMMIT_HASH)..."
docker build --build-arg VCS_REF="$COMMIT_HASH" --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` -f "$FILE" -t "approximator/$image:$VERSION" ..
docker run -ti --rm -v `pwd`/packages:/out/ --entrypoint bash "approximator/$image:$VERSION" -c "cp -vr /packages/. /out/"
