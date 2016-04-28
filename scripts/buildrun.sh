#!/bin/bash

if [ -z "$1" ]; then
    echo "Using docker-machine aem"
    docker-machine create aem --driver "virtualbox" --virtualbox-memory 2048
    eval $(docker-machine env aem)
fi

docker build -t centos-aem -f Dockerfile-aem .
scripts/run-aem.sh
scripts/postbuild.sh

open http://$(docker-machine ip aem):4502
