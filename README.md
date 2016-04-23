# AEM Docker Support

## Setting up Docker

Install [Docker Toolkit for Mac][dtmac] which will install all
the docker tools and virtualbox if needed and so on.  (Soon,
docker will release [Docker for Mac][dmac] which will eliminate the need
for using Virtualbox and the docker-machine setup here.)

[dtmac]: https://docs.docker.com/mac/step_one/
[dmac]: https://blog.docker.com/2016/03/docker-for-mac-windows-beta/

Setup a docker-machine.  Needs to have plenty of virutal
memory. Hoping we can get away with 2 Gb, but my test runs were
with 4 Gb

    docker-machine create aem-big --driver "virtualbox" --virtualbox-memory 2048
    eval $(docker-machine env aem-big)

## Building a base AEM image

Building a basic aem image, that can be used easily against a
prepared CRX directory.  Building too much into the image doesn't
add much benefit over bind mounting a directory into the a
running container.  So the image just establishes a working dir,
and provides a entrypoint command.


    docker build -t centos-aem -f Dockerfile-aem .

Note: the .dockerignore will prevent jars and other installation
materials from being pushed into the build context. You can
ignore this note if it's gibberish to you.


## Starting AEM

To use that image to run AEM

1. Create a working directory by cloning this git repo

     ```bash
     git clone git@github.com:Livefyre/docker-aem
     cd docker-aem
     ```

2. Add the installation materials to the directory

 - license.properties
 - YOUR_AEM_QUICKSTART.jar
 - Livefyre-AEM-Package.zip

3. Run the docker run command to start aem author

     ```bash
      export AEM_AUTHOR_JAR=YOUR_AEM_QUICKSTART_JAR

      ./run-aem.sh

      # It'll run the following, but may have changed:
      # docker run -v "$PWD:/aem" -m 2048M -e AEM_AUTHOR_JAR=$AEM_AUTHOR_JAR -p 4502:4502 centos-aem
     ```

4. It'll take a while, but eventually you'll have a running AEM,
that you can access at a network address on the docker
network. The following is likely to work for you on a Macbook:

      ```bash
      open http://192.168.99.100:4502/
      ```

