#!/bin/bash
ENVBASH=$1
ENVBASH=${ENVBASH:-"bash"}
#echo "ENVBASH=$ENVBASH"
docker run --rm -ti vertigo/docker-base:latest $ENVBASH ${@:2}
