#!/bin/bash

set -e

git clone $SOURCE_URI /tmp/src

cd /tmp/src

# Full image name
FULL_IMAGE_NAME="${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}"

buildah login -u walid1243 -p BirBir123Bir123 registry.redhat.io

# Build the image
buildah bud -t ${FULL_IMAGE_NAME} -f ./Dockerfile-tomcat .

cp /var/run/secrets/openshift.io/push/.dockercfg /tmp
(echo "{ \"auths\": " ; cat /var/run/secrets/openshift.io/push/.dockercfg ; echo "}") > /tmp/.dockercfg

buildah push --tls-verify=false ${FULL_IMAGE_NAME} 







