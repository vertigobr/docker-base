ENVBASH=$1
ENVBASH=${ENVBASH:-"bash"}
#echo "ENVBASH=$ENVBASH"
docker run --rm -t -i vertigobr/docker-base:latest $ENVBASH ${@:2}
