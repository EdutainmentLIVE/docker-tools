#! /usr/bin/env sh
set -o errexit
checkout
artifact pull workflow output
cp output/bin/* "$TOOL"
cp --recursive output/lib "$TOOL/ghc-lib"
docker build --tag "itprotv/$TOOL:$SEMAPHORE_GIT_SHA" "$TOOL"
echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin
docker push "itprotv/$TOOL:$SEMAPHORE_GIT_SHA"
