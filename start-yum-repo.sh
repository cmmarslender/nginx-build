#!/bin/bash

NAME=10up/yum
VERSION=1.0.0
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

GREEN='\033[0;32m'
NC='\033[0m'

printf "${GREEN}===> Start yum repository...${NC}\n"

IMAGE=$(docker images ${NAME} | awk '{ print $2 }' | grep -F "${VERSION}")
if [ -z $IMAGE ]; then
	pushd yum-repo > /dev/null
	printf "${GREEN}===> Build 10up/yum image...${NC}\n"
	docker build -q -t "${NAME}:${VERSION}" --rm .
	popd
fi

printf "${GREEN}===> Start the container and run yum repository...${NC}\n"
docker run -d -p 81:80 -v ${DIR}/packages:/var/packages ${NAME}:${VERSION}
