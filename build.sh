#!/bin/bash

VERSION=1.0.0

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

IMAGE=$(docker images | grep "10up/nginx")
if [ -z $IMAGE ]; then
    printf "${GREEN}===> Build 10up/nginx image...${NC}\n"
    docker build -q -t "10up/nginx:${VERSION}" .
fi

printf "${GREEN}===> Start the container and run build process...${NC}\n"
CONTAINERID=$(docker run -d 10up/nginx:${VERSION})
echo "Done..."

EXITCODE=$(docker wait $CONTAINERID)
if [ $EXITCODE -ne 0 ]; then
    printf "${RED}===> Build process returned not empty code...${NC}\n"
else
    printf "${GREEN}===> Copy RMPs out of the container...${NC}\n"
    docker cp $CONTAINERID:/root/rpmbuild/RPMS ./
    echo "RPMS copied..."
    docker cp $CONTAINERID:/root/rpmbuild/SRPMS ./
    echo "SRPMS copied..."
fi

printf "${GREEN}===> Remove the container...${NC}\n"
docker stop $CONTAINERID
docker rm $CONTAINERID