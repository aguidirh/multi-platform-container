#!/bin/bash
declare -a OS_LIST=("linux")
declare -a ARCH_LIST=("amd64" "arm64" "s390x" "ppc64le")

REGISTRY="YOUR_CONTAINER_REGISTRY_NAME_HERE"
USER="YOUR_USER_NAME_HERE"
REPOSITORY="YOUR_REPOSITORY_NAME_HERE"

for OS in "${OS_LIST[@]}"; do
  for ARCH in "${ARCH_LIST[@]}"; do
    echo "Building image for OS: $OS, ARCH: $ARCH"
    podman build --rm --build-arg MY_OS=${OS} --build-arg MY_ARCH=${ARCH} -t ${REGISTRY}/${USER}/${REPOSITORY}:${OS}_${ARCH} .
    echo "Pushing image for OS: $OS, ARCH: $ARCH"
    podman push ${REGISTRY}/${USER}/${REPOSITORY}:${OS}_${ARCH}
  done
done