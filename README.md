# About this Nginx

This version of Nginx is built with support of Google PageSpeed module (version 1.9.32.3). See the build script for details of where these dependencies live.

# Building Nginx

1) Ensure Vagrant 1.6.5 or higher is installed.

2) Run the following:

```
git clone https://github.com/eugene-manuilov/nginx-build.git
cd nginx-build
./build.sh
cd build/RPMS/x86_64
```

3) Enjoy your new RPMs, available in the current directory.

# Testing

Install built Nginx rpm and add following snippet to the ``/etc/nginx/nginx.conf/default.conf`` file:

```
pagespeed on
pagespeed FileCachePath /var/ngx_pagespeed_cache;
```

Restart Nginx service and execute ``curl -i http://localhost/`` command in your terminal and if everything works right you should see ``X-Page-Speed: 1.9.32.3-4448`` header in the response.

# Credits

* Thanks to [David Beitey](http://git.io/djb) and his [nginx-custom-build](https://github.com/jcu-eresearch/nginx-custom-build) repo for giving the initial insigh how to automate Nginx build process.