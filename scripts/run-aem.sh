#!/bin/bash

if [ -z "$AEM_AUTHOR_JAR" ]; then
    echo "Assuming the following quickstart jar:"
    export AEM_AUTHOR_JAR=cq-author-quickstart-6.1.0.jar
    echo "   $AEM_AUTHOR_JAR"
fi

docker run -v "$PWD:/opt/aem" -m 2048M -e AEM_AUTHOR_JAR=$AEM_AUTHOR_JAR -p 4502:4502 -d centos-aem
