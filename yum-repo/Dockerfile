# Yum repository for 10up RPMs.
FROM centos:6.6

# Declare image metadata
LABEL version="1.0.0" description="This image is used to create Yum repository for 10up RPMs." vendor="10up Inc"

# Copy required files
COPY start.sh /usr/local/bin/start-yum-repo

# Install required environment
RUN yum install -y createrepo httpd

# Define command to execute on container run
CMD start-yum-repo

# Open port 80
EXPOSE 80