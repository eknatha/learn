#!/usr/bin/env bash
# cleanup.sh — Remove stopped containers and dangling images
# Author: Eknatha Reddy | eknathalabs.com
echo "Removing stopped containers..."
docker container prune -f
echo "Removing dangling images..."
docker image prune -f
echo "Removing unused networks..."
docker network prune -f
echo "Done."
