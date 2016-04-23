#!/bin/bash
docker run -v "$PWD:/opt/aem" -m 2048M -e AEM_AUTHOR_JAR=$AEM_AUTHOR_JAR -p 4502:4502 centos-aem
