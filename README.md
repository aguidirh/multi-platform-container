## Overview

This is a simple POC that builds multi platform images to include into a simple image index

## Usage

Clone this repo

Build the multi platform images

```bash

./build-push-images.sh <registry> <namespace> <image-name>
```

Create an image index

```bash

./create-image-index.sh <registry> <namespace> <image-name>
```

## Verification

Run the container image which matches the CPU architecture running the command
```bash
podman run <registry> <namespace> <image-name>
```

Run the container image which matches the CPU architecture specified in the --arch
```bash
podman run --arch amd64 <registry> <namespace> <image-name>
```
