## 10up yum repository

### Launch yum repository

1) Ensure docker is installed.

2) Run the following:

```
git clone https://github.com/eugene-manuilov/nginx-build.git
cd nginx-build
./build-rpms.sh
./start-yum-repo.sh
```

3) Go to your browser and enter `http://localhost:81/CentOS/` address, you should see repository folders.

4) Configure repository on client by adding the following to the file at `/etc/yum.repos.d/10up`:

```
[10uprepo]
name=10up CentOS Repo
baseurl=http://your-host.com:81/CentOS
gpgcheck=0
```

5) Install the Nginx on the client.

## Nginx build

This version of Nginx is built with support of [Google PageSpeed](https://github.com/pagespeed/ngx_pagespeed) (version 1.9.32.3) and [Naxsi](https://github.com/nbs-system/naxsi) (version 0.53-2) modules using docker container. See the build-nginx.sh script for details of where these dependencies live.

#### Building Nginx

1) Ensure docker is installed.

2) Run the following:

```
git clone https://github.com/eugene-manuilov/nginx-build.git
cd nginx-build
./build-rpms.sh
cd packages/RPMS/x86_64
```

3) Enjoy your new RPMs, available in the current directory.

#### Testing Google PageSpeed module

Install built Nginx rpm and add following snippet to the ``/etc/nginx/nginx.conf/default.conf`` file:

```
pagespeed on;
pagespeed FileCachePath /var/ngx_pagespeed_cache;
```

Restart Nginx service and execute ``curl -i http://localhost/`` command in your terminal and if everything works right you should see ``X-Page-Speed: 1.9.32.3-4448`` header in the response.

For more information about how to configure PageSpeed module, see Google PageSpeed [documentation](https://developers.google.com/speed/pagespeed/module).

#### Testing Naxsi module

Please, refer to the [Naxsi documentation](https://github.com/nbs-system/naxsi/wiki) to setup basic configuration and check if it works accordingly to the documentation.