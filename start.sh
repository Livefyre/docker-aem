#!/bin/sh

if [ ! -e crx-quickstart ]
then
    echo "Unpacking ${AEM_AUTHOR_JAR:?} ..."
    java -jar $AEM_AUTHOR_JAR -unpack -v
    echo "    ... unpacking done"
fi

cp -p ./quickstart  crx-quickstart/bin/quickstart
crx-quickstart/bin/quickstart
