#!/bin/bash

set -e

ORG=${ORG:-hsldevcom}
DOCKER_TAG=${TRAVIS_COMMIT:-latest}
DOCKER_IMAGE=$ORG/digitransit-performance-tests
DOCKER_IMAGE_COMMIT=$DOCKER_IMAGE:$DOCKER_TAG
DOCKER_IMAGE_LATEST=$DOCKER_IMAGE:latest

# Build image
echo "Building digitransit-performance-tests"
docker build --tag="$DOCKER_IMAGE_COMMIT" .

if [ "${TRAVIS_PULL_REQUEST}" == "false" ]; then
    docker login -u $DOCKER_USER -p $DOCKER_AUTH
    echo "Pushing latest image"
    docker push $DOCKER_IMAGE_COMMIT
    docker tag $DOCKER_IMAGE_COMMIT $DOCKER_IMAGE_LATEST
    docker push $DOCKER_IMAGE_LATEST
fi


echo Build completed