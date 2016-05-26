# docker-base

Docker base image for Vertigo images (centos-based, at least for now)

[![](https://imagelayers.io/badge/vertigo/docker-base:latest.svg)](https://imagelayers.io/?images=vertigo/docker-base:latest 'Get your own badge on imagelayers.io')

This is a base CentOS 7 image with a few perks. This is based on
the official CentOS 7 base image.

Building this results in an updated CentOS image with
a few extra packages:

* net-tools
* tar
* wget
* unzip
* EPEL repo
* pwgen (from EPEL)

### What is it for?

Most images we find at the public Docker Hub are Ubuntu or Alpine-based.
Nothing against them, but Redhat customers feel more at home
with CentOS.

### Useful scripts

* **build.sh** : builds the image locally (docker build)
* **runbash.sh** : convenient way to run commands on a new
container (fast-food, auto-destroy) or even to just
open a bash shell to play.

### Build arguments

If you want to build this image yourself you can set the variables BASEREPO and EPELREPO before running `build.sh` in order to choose a specific "yum mirror" from your local network. Running local builds becomes a lot faster with a mirror around.

This is explained a [bit more here](BUILDARGS.md).

#### Some nice tests:

Show CentOS version:

    ./runbash.sh cat /etc/redhat-release
    CentOS Linux release 7.2.1511 (Core)

Show files (ls):

    ./runbash.sh ls -l /opt/
    total 0
