# Custom Nginx build with Google PageSpeed module
FROM centos:6.7

# Declare image metadata
LABEL version="1.9.9" description="This image is used to create RPM for custom Nginx build with Google PageSpeed module." vendor="10up Inc"

# Copy required files
COPY build.sh /usr/local/bin/build-nginx
COPY spec.patch /tmp/nginx-spec.patch

# First install wget
RUN yum install -y wget

# Need newer version of GCC than is provided by default
RUN rpm --import https://linux.web.cern.ch/linux/scientific6/docs/repository/cern/slc6X/i386/RPM-GPG-KEY-cern
RUN wget -O /etc/yum.repos.d/slc6-devtoolset.repo https://linux.web.cern.ch/linux/scientific6/docs/repository/cern/devtoolset/slc6-devtoolset.repo
RUN yum install -y devtoolset-2-gcc-c++ devtoolset-2-binutils

# Install required environment
RUN yum install -y rpm-build rpmdevtools yum-utils mercurial git unzip tar gcc-c++ pcre-dev pcre-devel zlib-devel make

# Define command to execute on container run
CMD build-nginx