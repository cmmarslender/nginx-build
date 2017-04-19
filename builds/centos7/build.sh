#!/bin/sh

PAGESPEED_VERSION=1.12.34.2

#Switch to sudo user
su -

#Clean up old nginx builds
rm -rf ~/rpmbuild/RPMS/*/nginx-*.rpm

#Install source RPM for Nginx
pushd ~
echo """[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/7/SRPMS/
gpgcheck=0
enabled=1""" >> nginx.repo
cp nginx.repo /etc/yum.repos.d/
yumdownloader --source nginx
rpm -ihv nginx*.src.rpm
popd

#Get various add-on modules for Nginx
pushd ~/rpmbuild/SOURCES

#Google PageSpeed
wget https://github.com/pagespeed/ngx_pagespeed/archive/v${PAGESPEED_VERSION}-beta.zip -O v${PAGESPEED_VERSION}-beta.zip
unzip v${PAGESPEED_VERSION}-beta.zip
mv ngx_pagespeed-${PAGESPEED_VERSION}-beta/ ngx_pagespeed

#Google PageSpeed PSOL
pushd ~/rpmbuild/SOURCES/ngx_pagespeed/
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url})  # extracts to psol/
popd

#Prep and patch the Nginx specfile for the RPMs
pushd ~/rpmbuild/SPECS
if [ -f "/tmp/nginx-spec.patch" ]; then
    cp /tmp/nginx-spec.patch ~/rpmbuild/SPECS/
fi
patch -p1 < nginx-spec.patch
spectool -g -R nginx.spec
yum-builddep -y nginx.spec
rpmbuild -ba nginx.spec
popd
