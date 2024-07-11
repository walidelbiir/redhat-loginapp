#!/bin/bash

set -e

git clone $SOURCE_URI /tmp/src

cd /tmp/src

# Set up variables for the internal registry
REGISTRY="image-registry.openshift-image-registry.svc:5000"
NAMESPACE="loginapp-dev"
IMAGE_STREAM_NAME="login-app-custom-strat"
IMAGE_TAG="latest" 
USERNAME="user"
PASSWORD="user@1243"

# Full image name
FULL_IMAGE_NAME="${REGISTRY}/${NAMESPACE}/${IMAGE_STREAM_NAME}:${IMAGE_TAG}"
#buildah login -u ${USERNAME} -p ${PASSWORD} $REGISTRY --tls-verify=false
#buildah login -u walidelbir -p 3asbaEL/123456 registy.redhat.io

# Authenticate with the internal registry
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
buildah login -u custom-builder -p ${TOKEN} ${REGISTRY} --tls-verify=false

# Build the image
buildah bud -t ${FULL_IMAGE_NAME} -f ./Dockerfile-tomcat .



# Connect to internal openshift registry


# Push the image
buildah push ${FULL_IMAGE_NAME} --tls-verify=false

echo "Image pushed successfully to ${FULL_IMAGE_NAME}"




