# AEM Docker Support


## Basic Setup

Setup a docker-machine.  Needs to have plenty of virutal
memory. Hoping we can get away with 2 Gb, but my test runs were
with 4 Gb

    docker-machine create aem-big --driver "virtualbox" --virtualbox-memory 2048

Building a basic aem image, that can be used easily against a
prepared CRX directory.  Building too much into the image doesn't
add much benefit over mounting a prepared directory into the
image.  The image just establishes a working dir, and provides a
start command (not entrypoint, so can use it interactively).

    docker build -t aem -f Dockerfile-aem .

This image can be used to create a CRX directory or after one has
been created.  It'll ignore all the installation files in its
working directory.

## Using Image to Prepare CRX Directory

To use that image

1. create a working directory to contain all the required files:


 - quickstart jar
 - license.properties and
 - a prebuilt content repository at "crx-quickstart/"

2. Run the docker run command to start aem author in that directory

     ```bash
     cd workingdir;
     docker run -v "$PWD:/aem" -p 4502:4502 -it -m 2048M aem
     ```
