#!/bin/bash
ENVBASH=$1
ENVBASH=${ENVBASH:-"bash"}
#echo "ENVBASH=$ENVBASH"
docker run --rm -t -i vertigo/docker-base:latest $ENVBASH ${@:2}
