#!/bin/bash
#
# This script allows a build argument to change the
# EPEL yum repo used for "yum install"
# commands.
#
# This allows local builds to point to local yum mirrors,
# while the Docker Hub automated build will use the default ones.
#
# Setting EPELREPO for any non-null/empty value will:
# . comment all "mirrorlist" entries in epel.repo
# . enable the "baseurl" entry with the value $EPELREPO
#
# Yeah, kinda rude, but it works. A special value "local"
# works as the value "http://registry.vtg/repos/epel/7/", our local EPEL mirror at home.
# Also another special value "default" restores epel.repo original file
# gained from "epel-release" package.
#

if [ "$EPELREPO" == "local" ]; then
    EPELREPO="http://registry.vtg/repos/epel/7/x86_64"
fi
if [ "$EPELREPO" == "default" ]; then
    cp /etc/yum.repos.d/epel.repo.original /etc/yum.repos.d/epel.repo
elif [[ ! -z $EPELREPO ]]; then
    echo "Using EPELREPO $EPELREPO"
    REPOMD="http://$EPELREPO/repodata/repomd.xml"
    echo "Testing $REPOMD..."
    CODE=$(curl -I $REPOMD 2>/dev/null | head -n 1 | cut -d$' ' -f2)
    if [ "$CODE" == "200" ]; then
        echo "...OK!"
    else
        >&2 echo "Error $CODE, repo can be broken/unreachable/etc., will proceed anyway. Pray."
    fi
    /usr/bin/cp -f /etc/yum.repos.d/epel.repo.original /etc/yum.repos.d/epel.repo
    REPO_ESC=$(sed 's/[\/\.]/\\&/g' <<<"$EPELREPO")
    echo "changing yum epel repos, escape EPELREPO=$REPO_ESC..."
    sed "s/^mirrorlist/#mirrorlist/g" -i /etc/yum.repos.d/epel.repo
    sed "0,/^#baseurl.*/s//baseurl=$REPO_ESC/g" -i /etc/yum.repos.d/epel.repo
fi
