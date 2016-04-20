#!/bin/sh

if [ ! -a crx-quickstart ]
then
    java -jar $CQ_AUTHOR_JAR -unpack -v
fi

crx-quickstart/bin/quickstart
