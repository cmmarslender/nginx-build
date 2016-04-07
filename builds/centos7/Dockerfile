# Custom Nginx build with Google PageSpeed module
FROM centos:7.1.1503

# Declare image metadata
LABEL version="1.9.10" description="This image is used to create RPM for custom Nginx build with Google PageSpeed module" vendor="10up Inc"

RUN yum install -y wget

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm && rpm -ivh epel-release-7-5.noarch.rpm

# Copy required files
COPY build.sh /usr/local/bin/build-nginx
COPY spec.patch /tmp/nginx-spec.patch

# Install required environment
RUN yum install -y rpm-build rpmdevtools yum-utils mercurial git unzip tar gcc-c++ pcre-dev pcre-devel zlib-devel make

# Define command to execute on container run
CMD build-nginx
