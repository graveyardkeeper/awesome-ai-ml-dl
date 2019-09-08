#!/bin/bash

set -e
set -u
set -o pipefail

IMAGE_NAME=${IMAGE_NAME:-jupyter-java}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  echo "DOCKER_USER_NAME not defined as an environment variable"
  exit -1
fi

DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

time docker build \
                 --build-arg WORKDIR=/jupyter-notebooks      \
                 -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} \
                 -f JuPyteR-Dockerfile .

./removeUnusedContainersAndImages.sh