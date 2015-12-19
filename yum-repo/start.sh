#!/bin/bash

# Switch to the sudo user
su -

# Create repository
createrepo /var/packages

# Delete the default webroot
rm -rf /var/www/html

# Create symlink to the packages folder
ln -s /var/packages /var/www/html

# Start Apache server in the foreground
/usr/sbin/httpd -DFOREGROUND