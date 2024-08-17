#!/bin/bash

{
    read -r TAG
} <version.txt
{
    read -r VPN_USERNAME
    read -r VPN_PASSWORD
} <creds.txt
docker stop underhill-cartographer >/dev/null 2>&1
docker rm underhill-cartographer >/dev/null 2>&1
docker pull josiahdc/cartographer:"$TAG"
docker pull josiahdc/trailhead:"${TAG}"
docker pull josiahdc/switchback:"${TAG}"
docker pull josiahdc/zenith:"${TAG}"
docker pull josiahdc/pathfinder:"${TAG}"
docker run \
    --restart always \
    -d \
    --name underhill-cartographer \
    -e TRAIL_COUNT=5 \
    -e VPN_USERNAME="$VPN_USERNAME" \
    -e VPN_PASSWORD="$VPN_PASSWORD" \
    --network host -v /var/run/docker.sock:/var/run/docker.sock \
    josiahdc/cartographer:"${TAG}"
