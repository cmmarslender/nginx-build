#!/bin/bash

NAME=nginx/centos7
VERSION=1.9.9

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

printf "${GREEN}===> Build Nginx...${NC}\n"

IMAGE=$(docker images ${NAME} | awk '{ print $2 }' | grep -F "${VERSION}")
if [ -z $IMAGE ]; then
	pushd builds/centos7
	printf "${GREEN}===> Build nginx/centos7 image...${NC}\n"
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
	printf "${GREEN}===> Copy RPMs out of the container...${NC}\n"
	docker cp $CONTAINERID:/root/rpmbuild/RPMS ./packages/CentOS/7/
	mv ./packages/CentOS/7/RPMS/* ./packages/CentOS/7/
	rm -rf ./packages/CentOS/7/RPMS
	echo "RPMS copied..."
	docker cp $CONTAINERID:/root/rpmbuild/SRPMS ./packages/CentOS/7/
	echo "SRPMS copied..."
fi

printf "${GREEN}===> Remove the container...${NC}\n"
docker stop $CONTAINERID
docker rm $CONTAINERID