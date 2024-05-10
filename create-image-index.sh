#!/bin/bash
declare -a OS_LIST=("linux")
declare -a ARCH_LIST=("amd64" "arm64" "s390x" "ppc64le")

REGISTRY="YOUR_CONTAINER_REGISTRY_NAME_HERE"
NAMESPACE="YOUR_NAMESPACE_HERE"
IMAGE_NAME="YOUR_IMAGE_NAME_HERE"

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