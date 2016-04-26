# AEM Docker Support

## The really fast path

The following steps are the really fast path a Mac OSX user
(non-developer).

1. Download and install [Docker Toolkit for Mac][dtmac]. You
should be able to just accept all defaults through the
installation screens.

2. Open Terminal - You can spotlight search with "CMD-Space"
Terminal

3. Set up a working directory.  You will need to have a github
login, and

    ```bash
     git clone https://github.com:Livefyre/docker-aem
     cd docker-aem
    ```

4. Copy the installation files to the workding directory

 - license.properties
 - YOUR_AEM_QUICKSTART.jar
 - Livefyre-AEM-Package.zip (not really needed until setting up Livefyre)

5. Run the script that does everything

    ```bash
    scripts/buildrun.sh
    ```

6. Setup Livefyre following [instructions below](#lfsetup).

## The Step by Step for Developers

### Install Docker Tools

#### Mac OSX
Install [Docker Toolkit for Mac][dtmac] which will install all
the docker tools and virtualbox if needed and so on.  (Soon,
docker will release [Docker for Mac][dmac] which will eliminate the need
for using Virtualbox and the docker-machine setup here.)

[dtmac]: https://docs.docker.com/mac/step_one/
[dmac]: https://blog.docker.com/2016/03/docker-for-mac-windows-beta/

#### Windows setup

You are probably more able to solve this problem :) Seriously, you'll easily find
the equivalent installer, and you should use cygwin, and know what you are doing.
If you do that you can build the docker image and certainly everything else in the same fromhere on.

### Setup Docker Host Virtual Machine

Setup a docker-machine.  Needs to have plenty of virutal
memory, 2 Gb looks sufficient, but could give it more.

    docker-machine create aem --driver "virtualbox" --virtualbox-memory 2048
    eval $(docker-machine env aem)


### Building a base docker image that will launch AEM

1. Create a working directory by cloning this git repo

     ```bash
     git clone git@github.com:Livefyre/docker-aem
     cd docker-aem
     ```

2. Build an aem image.  Building too much into the image doesn't
   add much value over bind mounting a directory into the a running container.
   So the image just establishes a working dir, and provides a entrypoint command.

    ```bash
    docker build -t centos-aem -f Dockerfile-aem .
    ```

Note: the .dockerignore will prevent jars and other installation
materials from being pushed into the build context. You can
ignore this note if it's gibberish to you.


### Starting an AEM Author instance

To use that image to run AEM

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

### Installing the Livefyre package into the AEM instance

2. After AEM is running, you can run a script to install the
Livefyre package and make some generic configuration changes that
are needed.

      ```bash
      cd <workingdir> # as above
      scripts/lfsetup.sh
      ```

2. Also after AEM is fully running, you will be able to login to
AEM in your browser at the network address of the docker-machine
you created.  The following will work on a Macbook:

      ```bash
      docker-machine ls
      export AEM_HOST=$(docker-machine ip aem)
      open http://$AEM_HOST:4502/
      ```


## <a name="lfsetup"></a>Setup Livefyre on an AEM site/page

To setup Livefyre, you'll need to setup the cloud config one
time, and apply the configuration & setup components for
sites/pages you want to use livefyre.

3. At this point, you must setup your Livefyre cloud
   service config in the AEM application (automation to come):
    2. Click "Tools" -> "Opertaions" -> "Cloud" -> Cloud Services
    3. Locate "Livefyre" under "Third Party Services"
    4. Click "Configure Now"
    5. Give the configuration a title and name, click Create
    6. Then enter the Network Domain, Network Key, Site ID, Site Key
    7. Click OK, then "Cloud Services" in the breadcrumb to get out of there!

1. Apply the configuration to a Page
    1. Go to Projects page, URL will look like http://192.168.99.100:4502/projects.html
    2. Select a Page by mousing over a project collection, clicking the "pencil" icon
    3. Open a Page in the Page Editor
    4. Click "Open Properties", top left corner looks like a series of silders
    5. Click to the "Cloud Services" panel
    6. Uncheck a box that says "Inherit ... blah blah blah"
    6. Click "Add Confguration", Choose Livefyre
    7. It should pick the one you created, if you have more than one configuration chose it here.
    8. Press the check in the top right corner

2. Configuring Available Components
    0. This screencast intends to show how to do the following steps, http://d.pr/v/U5yR
    1. Given an open page being edited
    2. Ensure you are in "Design" mode
    3. Select a component container by clicking on one
    4. For the selected container click the newspaper icon
    5. This will expand the container selection to its parent and surface a wrench icon
    6. Clicking the wrench icon will allow you to configure available components for that section
    7. Find Livefyre (don't be fulled by alphabetization of sublevels) and enable it by selecting the top level checkbox
