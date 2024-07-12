#!/bin/bash

set -e

git clone $SOURCE_URI /tmp/src

cd /tmp/src

# Full image name
FULL_IMAGE_NAME="${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}"
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)

buildah login -u walid1243 -p BirBir123Bir123 registry.redhat.io

# Build the image
buildah bud -t ${FULL_IMAGE_NAME} -f ./Dockerfile-tomcat .

buildah login -u builder -p ${TOKEN} ${OUTPUT_REGISTRY} --tls-verify=false

buildah push --tls-verify=false ${FULL_IMAGE_NAME} 







