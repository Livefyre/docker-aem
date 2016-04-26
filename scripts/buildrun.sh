#!/bin/bash

if [ -z "$AEM_AUTHOR_JAR" ]; then
    echo "Assuming the following quickstart jar:"
    export AEM_AUTHOR_JAR=cq-author-quickstart-6.1.0.jar
    echo "   $AEM_AUTHOR_JAR"
fi

docker-machine create aem --driver "virtualbox" --virtualbox-memory 2048
eval $(docker-machine env aem)
docker build -t centos-aem -f Dockerfile-aem .
scripts/run-aem.sh
scripts/postbuild.sh

open http://$(docker-machine ip aem):4502
