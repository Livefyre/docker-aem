#!/bin/sh

if [ ! -e crx-quickstart ]
then
    echo
    echo "Unpacking ${AEM_AUTHOR_JAR:?} ..."
    java -jar $AEM_AUTHOR_JAR -unpack -v
    echo "    ... unpacking done"
    echo
fi

export CQ_JARFILE=./$AEM_AUTHOR_JAR
cp -p ./quickstart  crx-quickstart/bin/quickstart
crx-quickstart/bin/quickstart
