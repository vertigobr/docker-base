#!/bin/bash
#
# This script allows a build argument to change the
# CentOS-Base yum repo used for all "yum install"
# commands.
#
# This allows local builds to point to local yum mirrors,
# while the Docker Hub automated build will use the default ones.
#
# Setting BASEREPO for any non-null/empty value will:
# . disable fastestmirror plugin
# . comment all "mirrorlist" entries in CentOS-Base.repo
# . enable "baseurl" entries replacing "mirror.centos.org" by $BASEREPO in CentOS-Base.repo
#
# Yeah, kinda rude, but it works. A special value "local"
# works as the value "registry.vtg/repos", our local mirror at home.
# Also another special value "default" restores CentOS-Base.repo original file
# from "centos" base image and enables fastest mirror again.
#

if [ "$BASEREPO" == "local" ]; then
    BASEREPO="registry.vtg/repos"
fi
if [ "$BASEREPO" == "default" ]; then
    cp /etc/yum.repos.d/CentOS-Base.repo.original /etc/yum.repos.d/CentOS-Base.repo
    sed "s/^enabled.*/enabled=1/" -i /etc/yum/pluginconf.d/fastestmirror.conf
elif [[ ! -z $BASEREPO ]]; then
    echo "Using BASEREPO $BASEREPO"
    REPOMD="http://$BASEREPO/centos/7/os/x86_64/repodata/repomd.xml"
    echo "Testing $REPOMD..."
    CODE=$(curl -I $REPOMD 2>/dev/null | head -n 1 | cut -d$' ' -f2)
    if [ "$CODE" == "200" ]; then
        echo "...OK!"
    else
        >&2 echo "Error $CODE, repo can be broken/unreachable/etc., will proceed anyway. Pray."
    fi
    /usr/bin/cp -f /etc/yum.repos.d/CentOS-Base.repo.original /etc/yum.repos.d/CentOS-Base.repo
    echo "disabling fastest mirror..."
    sed "s/^enabled.*/enabled=0/" -i /etc/yum/pluginconf.d/fastestmirror.conf
    REPO_ESC=$(sed 's/[\/\.]/\\&/g' <<<"$BASEREPO")
    echo "changing yum base repos, escape BASEREPO=$REPO_ESC..."
    sed "s/^mirrorlist/#mirrorlist/g" -i /etc/yum.repos.d/CentOS-Base.repo
    sed "s/^#baseurl/baseurl/g" -i /etc/yum.repos.d/CentOS-Base.repo
    sed "s/mirror\.centos\.org/$REPO_ESC/g" -i /etc/yum.repos.d/CentOS-Base.repo
fi
