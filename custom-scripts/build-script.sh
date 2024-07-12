#!/bin/bash

set -e

#git clone $SOURCE_URI /tmp/src

cd ${SOURCE_REPOSITORY}

# Full image name
FULL_IMAGE_NAME="${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}"

# Build the image
buildah bud -t ${FULL_IMAGE_NAME} -f ./Dockerfile-tomcat .







