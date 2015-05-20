# About this Nginx

This version of Nginx is built with support of [Google PageSpeed](https://github.com/pagespeed/ngx_pagespeed) (version 1.9.32.3) and [Naxsi](https://github.com/nbs-system/naxsi) (version 0.53-2) modules using docker container. See the build-nginx.sh script for details of where these dependencies live.

# Building Nginx

1) Ensure docker is installed.

2) Run the following:

```
git clone https://github.com/eugene-manuilov/nginx-build.git
cd nginx-build
./build.sh
cd RPMS/x86_64
```

3) Enjoy your new RPMs, available in the current directory.

# Testing Google PageSpeed module

Install built Nginx rpm and add following snippet to the ``/etc/nginx/nginx.conf/default.conf`` file:

```
pagespeed on;
pagespeed FileCachePath /var/ngx_pagespeed_cache;
```

Restart Nginx service and execute ``curl -i http://localhost/`` command in your terminal and if everything works right you should see ``X-Page-Speed: 1.9.32.3-4448`` header in the response.

For more information about how to configure PageSpeed module, see Google PageSpeed [documentation](https://developers.google.com/speed/pagespeed/module).

# Testing Naxsi module

Please, refer to the [Naxsi documentation](https://github.com/nbs-system/naxsi/wiki) to setup basic configuration and check if it works accordingly to the documentation.