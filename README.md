# docker-base

[![Build Status](http://drone.vertigo.com.br/api/badges/docker/docker-base/status.svg)](http://drone.vertigo.com.br/docker/docker-base)
[![](https://badge.imagelayers.io/vertigo/docker-base:latest.svg)](https://imagelayers.io/?images=vertigo/docker-base:latest 'Get your own badge on imagelayers.io')

Docker base image for Vertigo images (centos-based, at least for now)

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

You can set the variables BASEREPO and EPELREPO before running build.sh in order to choose a specific "yum mirror" from your local network. Running local builds becomes a lot faster with a mirror around.

Setting BASEREPO for any non-null/empty value will:

- disable fastestmirror plugin
- comment all "mirrorlist" entries in CentOS-Base.repo
- enable "baseurl" entries replacing "mirror.centos.org" by BASEREPO in CentOS-Base.repo

Setting EPELREPO for any non-null/empty value will:

- comment all "mirrorlist" entries in epel.repo
- enable "baseurl" with value BASEREPO in epel.repo

#### Some nice tests:

Show CentOS version:

    ./runbash.sh cat /etc/redhat-release
    CentOS Linux release 7.2.1511 (Core)

Show files (ls):

    ./runbash.sh ls -l /opt/
    total 0
