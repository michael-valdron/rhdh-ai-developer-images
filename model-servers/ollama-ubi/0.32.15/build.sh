#!/bin/bash

BASE_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

if [ -f "${BASE_DIR}/config.env" ]; then
    . "${BASE_DIR}/config.env"
fi

CONTAINER_ENGINE="${CONTAINER_ENGINE:-podman}"
IMAGE_NAME="${IMAGE_NAME:-quay.io/redhat-ai-dev/ollama-ubi}"
IMAGE_TAG="${IMAGE_TAG:-''}"

if [ -n "${IMAGE_TAG}" ]; then
    $CONTAINER_ENGINE build --no-cache --build-arg=OLLAMA_VERSION=${IMAGE_TAG} -t $IMAGE_NAME:latest -f Containerfile
    $CONTAINER_ENGINE tag $IMAGE_NAME:latest $IMAGE_NAME:${IMAGE_TAG}
else
    echo "expected 'IMAGE_TAG' unset" >&2; exit 1
fi
