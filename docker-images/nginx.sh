#!/bin/bash

NAME=10up/nginx
VERSION=1.0.0

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

printf "${GREEN}===> Build Nginx...${NC}\n"

IMAGE=$(docker images ${NAME} | awk '{ print $2 }' | grep -F "${VERSION}")
if [ -z $IMAGE ]; then
	pushd docker-images/nginx
	printf "${GREEN}===> Build 10up/nginx image...${NC}\n"
	docker build -q -t "${NAME}:${VERSION}" --rm .
	popd
fi

printf "${GREEN}===> Start the container and run build process...${NC}\n"
CONTAINERID=$(docker run -d ${NAME}:${VERSION})
echo "Waiting until container finishes running..."

EXITCODE=$(docker wait $CONTAINERID)
if [ $EXITCODE -ne 0 ]; then
	printf "${RED}===> Build process returned not empty code...${NC}\n"
else
	printf "${GREEN}===> Copy RMPs out of the container...${NC}\n"
	docker cp $CONTAINERID:/root/rpmbuild/RPMS ./packages/
	echo "RPMS copied..."
	docker cp $CONTAINERID:/root/rpmbuild/SRPMS ./packages/
	echo "SRPMS copied..."
fi

printf "${GREEN}===> Remove the container...${NC}\n"
docker stop $CONTAINERID
docker rm $CONTAINERID