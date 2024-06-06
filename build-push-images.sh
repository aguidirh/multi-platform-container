#!/bin/bash
declare -a OS_LIST=("linux")
declare -a ARCH_LIST=("amd64" "arm64" "s390x" "ppc64le")

if [ $# -eq 0 ]
  then
    echo -e "\nUsage : ./build-push-images.sh <registry> <namespace> <image-name>"
    echo -e "No arguments supplied, using defaults\n"
fi


REGISTRY="${1:-test}"
NAMESPACE="${2:-test}"
IMAGE_NAME="${3:-test}"

REPO=${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}

for OS in "${OS_LIST[@]}"; do
  for ARCH in "${ARCH_LIST[@]}"; do
    echo "Building image for OS: $OS, ARCH: $ARCH"
    podman build --rm --build-arg MY_OS=${OS} --build-arg MY_ARCH=${ARCH} -t ${REPO}:${OS}_${ARCH} .
    echo "Pushing image for OS: $OS, ARCH: $ARCH"
    podman push ${REPO}:${OS}_${ARCH}
  done
done
