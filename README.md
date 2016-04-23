# AEM Docker Support

## Setting up Docker

### Mac setup

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
    
### Windows setup

You are probably more able to solve this problem :) Seriously, you'll easily find
the equivalent installer, and you should use cygwin, and know what you are doing.
If you do that you can build the docker image and certainly everything else in the same fromhere on.

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


## Starting an AEM Author instance

To use that image to run AEM

1. Create a working directory by cloning this git repo

     ```bash
     git clone git@github.com:Livefyre/docker-aem
     cd docker-aem
     ```

2. Add the installation files to the directory

 - license.properties
 - YOUR_AEM_QUICKSTART.jar
 - Livefyre-AEM-Package.zip (not really needed until setting up Livefyre)

3. Run the docker run command to start aem author

     ```bash
      export AEM_AUTHOR_JAR=YOUR_AEM_QUICKSTART_JAR

      ./run-aem.sh

      # It'll run the following, but may have changed:
      # docker run -v "$PWD:/aem" -m 2048M -e AEM_AUTHOR_JAR=$AEM_AUTHOR_JAR -p 4502:4502 centos-aem
     ```

It'll take a while, but eventually you'll have a running
AEM. You will see a message in that console that says "Quickstart
started. 

## Setting up Livefyre in AEM instance

The terminal you started AEM in will be occupied by the running 
container, so you will need a 2nd terminal for further steps.
(Easy enough to do different things here with a little docker
knowledge e.g. detach this container, and observe its logs with
docker commands when needed.)

1. After, AEM is fully running, you will be able to login to AEM in your
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

2. At the same time, you can run a script that will install the
Livefyre package and make some generic configuration changes that
are needed.

      ```bash
      scripts/lfsetup
      ```

3. At this point, you must setup your Livefyre cloud
   service config in the AEM application (automation to come):

    2. Click "Tools" -> "Opertaions" -> "Cloud" -> Cloud Services
    3. Locate "Livefyre" under "Third Party Services"
    4. Click "Configure Now"
    5. Give the configuration a title and name, click Create
    6. Then enter the Network Domain, Network Key, Site ID, Site Key
    7. Click OK, then AEM to get out of there!
