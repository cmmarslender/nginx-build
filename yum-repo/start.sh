#!/bin/bash

# Switch to the sudo user
su -

# Create repository
createrepo /var/packages

# Create symlink to the packages folder
ln -s /var/packages /var/www/html/CentOS

# Start Apache server in the foreground
/usr/sbin/httpd -DFOREGROUND