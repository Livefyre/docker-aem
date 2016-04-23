# AEM Docker Support

## Setting up Docker

Install [Docker Toolkit for Mac][dtmac] which will install all
the docker tools and virtualbox if needed and so on.  (Soon,
docker will release [Docker for Mac][dmac] which will eliminate the need
for using Virtualbox and the docker-machine setup here.)

[dtmac]: https://docs.docker.com/mac/step_one/
[dmac]: https://blog.docker.com/2016/03/docker-for-mac-windows-beta/

Setup a docker-machine.  Needs to have plenty of virutal
memory, 2 Gb looks sufficient, but could give it more.

    docker-machine create aem --driver "virtualbox" --virtualbox-memory 2048
    eval $(docker-machine env aem)

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

The terminal will now be occupied by the running docker
container, so you will need a 2nd terminal for further steps.
(Easy enough to do different things here with a little docker
knowledge e.g. detach this container, and observe its logs with
docker commands when needed.)

4. It'll take a while, but eventually you'll have a running
AEM. You will see a message in that console that says "Quickstart
started." At this point you will be able to login to AEM in your
browser at the network address of the docker-machine you created.
The following is likely to work for you on a Macbook. If you've
created other docker machines before, than you might need to
change the 100 to 101 or 102, but you can tell from the ls
command:

      ```bash
      docker-machine ls
      export AEM_HOST=192.168.99.100
      open http://$AEM_HOST:4502/
      ```

5. After you can login, run a script that will install the
Livefyre package and make some generic configuration changes that
are needed.

      ```bash
      scripts/lfsetup
      ```

6. At this point, you'll be have to setup your Livefyre cloud
   service config, and do the required things to apply this
   config to sites/pages on which you want to use Livefyre
   components
