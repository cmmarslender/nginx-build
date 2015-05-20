#!/bin/bash

CONTAINERID=$(docker run -d 10up/nginx build-nginx)

docker wait $CONTAINERID

docker cp $CONTAINERID:/root/rpmbuild/RPMS ./
docker cp $CONTAINERID:/root/rpmbuild/SRPMS ./

docker stop $CONTAINERID
docker rm $CONTAINERID