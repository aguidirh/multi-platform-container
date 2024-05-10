#!/bin/bash
declare -a OS_LIST=("linux")
declare -a ARCH_LIST=("amd64" "arm64" "s390x" "ppc64le")

REGISTRY="YOUR_CONTAINER_REGISTRY_NAME_HERE"
NAMESPACE="YOUR_NAMESPACE_HERE"
IMAGE_NAME="YOUR_IMAGE_NAME_HERE"

REPO=${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}

for OS in "${OS_LIST[@]}"; do
  for ARCH in "${ARCH_LIST[@]}"; do
    echo "Building image for OS: $OS, ARCH: $ARCH"
    podman build --rm --build-arg MY_OS=${OS} --build-arg MY_ARCH=${ARCH} -t ${REPO}:${OS}_${ARCH} .
    echo "Pushing image for OS: $OS, ARCH: $ARCH"
    podman push ${REPO}:${OS}_${ARCH}
  done
done