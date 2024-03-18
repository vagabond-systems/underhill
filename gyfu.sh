#!/bin/bash

TAG="0.24"

# build image
docker buildx build --platform linux/amd64 -t josiahdc/trail:${TAG} ./trail --push
