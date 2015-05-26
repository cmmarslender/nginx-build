# Custom Nginx build with Google PageSpeed and Naxsi modules.
FROM centos:6.6

# Declare image metadata
LABEL version="1.0" description="This image is used to create RPM for custom Nginx build with Google PageSpeed and Naxsi modules." vendor="10up Inc"

# Copy required files
COPY nginx-build.sh /usr/local/bin/build-nginx
COPY nginx-spec.patch /tmp/nginx-spec.patch

# Install required environment
RUN yum install -y rpm-build rpmdevtools yum-utils mercurial git wget unzip tar gcc-c++ pcre-dev pcre-devel zlib-devel make

# Define command to execute on container run
CMD build-nginx