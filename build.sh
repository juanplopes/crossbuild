#!/bin/bash
docker build -t juanplopes/crossbuild:manifest-amd64 --platform amd64 .
docker push juanplopes/crossbuild:manifest-amd64

docker build -t juanplopes/crossbuild:manifest-arm64v8 --platform arm64 .
docker push juanplopes/crossbuild:manifest-arm64v8

docker manifest create juanplopes/crossbuild:latest \
              --amend juanplopes/crossbuild:manifest-amd64 \
              --amend juanplopes/crossbuild:manifest-arm64v8

docker manifest push --purge juanplopes/crossbuild:latest