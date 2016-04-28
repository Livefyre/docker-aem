#!/bin/bash

if [ -z "$AEM_HOST" ]; then
    export AEM_HOST=$(docker-machine ip aem)
fi

response=$(curl --write-out %{http_code} --silent --output /dev/null http://$AEM_HOST:4502)    

while [ $response -ne "401" ]
do
   echo "Server still initializing"    
   sleep 30s
   response=$(curl --write-out %{http_code} --silent --output /dev/null http://$AEM_HOST:4502)
done

echo "Installing Livefyre package"

scripts/lfsetup.sh
