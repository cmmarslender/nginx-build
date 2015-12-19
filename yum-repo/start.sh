#!/bin/bash

# Switch to the sudo user
su -

# Create repositories
createrepo /var/packages/CentOS/6/x86_64/
createrepo /var/packages/CentOS/7/x86_64/

# Delete the default webroot
rm -rf /var/www/html

# Get rid of the "welcome" page
rm /etc/httpd/conf.d/welcome.conf

# Create symlink to the packages folder
ln -s /var/packages /var/www/html

# Start Apache server in the foreground
/usr/sbin/httpd -DFOREGROUND