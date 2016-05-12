#!/usr/bin/env bash

readonly USER="dting"
readonly REPOSITORY="jupyter"
readonly VERSION="latest"
readonly IMAGE=${USER}/${REPOSITORY}:${VERSION}

docker run --rm -p 8888:8888 --name ${REPOSITORY} -v ${2:-$PWD}/notebooks:/notebooks ${IMAGE}
