#!/bin/bash
declare -a OS_LIST=("linux")
declare -a ARCH_LIST=("amd64" "arm64" "s390x" "ppc64le")

if [ $# -eq 0 ]
  then
    echo -e "\nUsage : ./create-image-index.sh <registry> <namespace> <image-name>"
    echo -e "No arguments supplied, using defaults\n"
fi

REGISTRY="${1:-test}"
NAMESPACE="${2:-test}"
IMAGE_NAME="${3:-test}"

REPO=${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}

echo "Creating image index for $REPO:latest"
podman manifest create $REPO:latest

for OS in "${OS_LIST[@]}"; do
  for ARCH in "${ARCH_LIST[@]}"; do
    echo "Adding image for OS: $OS, ARCH: $ARCH to the image index"
    podman manifest add --arch=${ARCH} --os=${OS} $REPO:latest docker://$REPO:${OS}_${ARCH}
  done
done

echo "Pushing image index for $REPO:latest"
podman manifest push -f oci --all $REPO:latest docker://$REPO:latest
