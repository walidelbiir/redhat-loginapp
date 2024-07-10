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

# Build the image
buildah bud -t ${FULL_IMAGE_NAME} -f ./Dockerfile-tomcat .

# Authenticate with the internal registry
#TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
#buildah login -u openshift -p ${TOKEN} ${REGISTRY} --tls-verify=false

# Connect to internal openshift registry
buildah login -u ${USERNAME} -p ${PASSWORD} $REGISTRY --tls-verify=false

# Push the image
buildah push ${FULL_IMAGE_NAME} --tls-verify=false

echo "Image pushed successfully to ${FULL_IMAGE_NAME}"




