#!/usr/bin/env bash
# build-and-run.sh — Build and run a Docker container
# Author: Eknatha Reddy | eknathalabs.com
IMAGE="${1:-myapp}"
TAG="${2:-latest}"
PORT="${3:-8080}"
docker build -t "${IMAGE}:${TAG}" .
docker run -d --name "${IMAGE}" -p "${PORT}:${PORT}" "${IMAGE}:${TAG}"
echo "Running at http://localhost:${PORT}"
