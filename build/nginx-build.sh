#!/bin/sh

NPS_VERSION=1.9.32.3

#Switch to sudo user
sudo su -

#Clean up old nginx builds
rm -rf ~/rpmbuild/RPMS/*/nginx-*.rpm

#Install required packages for building
yum install -y \
    rpm-build \
    rpmdevtools \
    yum-utils \
    mercurial \
    git \
    wget \
    unzip \
    tar


#Install source RPM for Nginx
pushd ~
echo """[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/SRPMS/
gpgcheck=0
enabled=1""" >> nginx.repo
cp nginx.repo /etc/yum.repos.d/
yumdownloader --source nginx
rpm -ihv nginx*.src.rpm
popd


#Get various add-on modules for Nginx
pushd ~/rpmbuild/SOURCES

#Google PageSpeed
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-${NPS_VERSION}-beta.zip -O release-${NPS_VERSION}-beta.zip
unzip release-${NPS_VERSION}-beta.zip
mv ngx_pagespeed-release-${NPS_VERSION}-beta/ ngx_pagespeed
pushd ~/rpmbuild/SOURCES/ngx_pagespeed/
wget https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz -O ${NPS_VERSION}.tar.gz
tar -xzvf ${NPS_VERSION}.tar.gz  # extracts to psol/
popd

popd

#Prep and patch the Nginx specfile for the RPMs
#Note: expects to have the repository contents located in ~/rpmbuild/SPECS/
#      or located at /vagrant 
pushd ~/rpmbuild/SPECS
if [ -d "/vagrant" ]; then
    cp /vagrant/nginx-spec.patch ~/rpmbuild/SPECS/
fi
patch -p1 < nginx-spec.patch
spectool -g -R nginx.spec
yum-builddep -y nginx.spec
rpmbuild -ba nginx.spec

#Test installation and check output
yum remove -y nginx nginx-devel
yum install -y ~/rpmbuild/RPMS/*/nginx-*.rpm
nginx -V