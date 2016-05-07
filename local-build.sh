#!/bin/sh
BASEREPO="192.168.1.8/repos"
EPELREPO=
docker build \
    --build-arg="BASEREPO=$BASEREPO" \
    --build-arg="EPELREPO=$EPELREPO" \
    -t vertigo/docker-base .
