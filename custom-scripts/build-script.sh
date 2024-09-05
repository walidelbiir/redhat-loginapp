#!/bin/bash

set -e


#echo $PAT_KEY | gh auth login --with-token

REPO_WITH_TOKEN="https://${PAT_KEY}@github.com/walidelbiir/redhat-loginapp.git"

git clone $REPO_WITH_TOKEN /tmp/src


cd /tmp/src

# Full image name
FULL_IMAGE_NAME="${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}"
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)

buildah login -u ${REDHAT_USERNAME} -p ${REDHAT_PASSWORD} registry.redhat.io

# Build the image
buildah bud -t ${FULL_IMAGE_NAME} -f ./Dockerfile-tomcat .

buildah login -u ${SERVICE_ACCOUNT} -p ${TOKEN} ${OUTPUT_REGISTRY} --tls-verify=false

cp /var/run/secrets/openshift.io/push/.dockercfg /tmp
(echo "{ \"auths\": " ; cat /var/run/secrets/openshift.io/push/.dockercfg ; echo "}") > /tmp/.dockercfg

buildah push --tls-verify=false --authfile /tmp/.dockercfg ${FULL_IMAGE_NAME} 