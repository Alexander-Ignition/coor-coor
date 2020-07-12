#!/bin/bash

set -eu

echo "-------------------------------------------------------------------------"
echo "preparing docker build image"
echo "-------------------------------------------------------------------------"
docker build -t swift-lambda-builder .
echo "done"

echo "-------------------------------------------------------------------------"
echo "building lambda"
echo "-------------------------------------------------------------------------"
docker run \
    --rm \
    --volume "$(pwd)/:/src" \
    --workdir "/src/" \
    swift-lambda-builder \
    swift build -c release
echo "done"

echo "-------------------------------------------------------------------------"
echo "packaging lambda"
echo "-------------------------------------------------------------------------"
docker run \
    --rm \
    --volume "$(pwd)/:/src" \
    --workdir "/src/" \
    swift-lambda-builder \
    scripts/package.sh coor-coor
echo "done"
