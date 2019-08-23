#!/bin/bash

image="qt"
VERSION="conan_build"

FILE="Dockerfile_conan_5.13.0"
COMMIT_HASH=`git log -1 --format=%H ../"$FILE"`
echo "Building approximator/$image:$VERSION (Commit: $COMMIT_HASH)..."

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

cd "$SCRIPT_DIR"

docker build  \
  --build-arg VCS_REF="$COMMIT_HASH" \
  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
  -f "$FILE" -t "approximator/$image:$VERSION" .

docker run --rm -ti                     \
  -e BINTRAY_APIKEY="$BINTRAY_APIKEY"   \
  -e BUILD_TYPE="$BUILD_TYPE"           \
  -e LIBCXX="$LIBCXX"                   \
  "approximator/$image:$VERSION"        \
  bash -c "conan user -p $BINTRAY_APIKEY -r approximator approximator && conan install /conanfile -s build_type=$BUILD_TYPE --build=missing && conan upload qt/5.13.0@bincrafters/stable --all -r=approximator"
