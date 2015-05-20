#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

IMAGE=$(docker images | grep "10up/nginx")
if [ -z $IMAGE ]; then
    printf "${GREEN}Build 10up/nginx image...${NC}"
    docker build -q -t "10up/nginx" .
fi

printf "${GREEN}Start the container and run build process...${NC}"
CONTAINERID=$(docker run -d 10up/nginx build-nginx)

EXITCODE=$(docker wait $CONTAINERID)
if [ $EXITCODE -ne 0 ]; then
    printf "${RED}Build process returned not empty code...${NC}"
else
    printf "${GREEN}Copy RMPs out of the container...${NC}"
    docker cp $CONTAINERID:/root/rpmbuild/RPMS ./
    docker cp $CONTAINERID:/root/rpmbuild/SRPMS ./
fi

printf "${GREEN}Remove the container...${NC}"
docker stop $CONTAINERID
docker rm $CONTAINERID