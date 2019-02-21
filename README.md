# codiusd-gui-docker
Docker for Codiusd admin GUI

[codiusd-gui][1] is a admin GUI for codiusd 

Docker images are built for quick deployment in various computing cloud providers. For more information on docker and containerization technologies, refer to [official document][4].

## Prepare the host

Many cloud providers offer docker-ready environments, for instance the [CoreOS Droplet in DigitalOcean][5] or the [Container-Optimized OS in Google Cloud][6].

If you need to install docker yourself, follow the [official installation guide][7].

for enable admin api on codius host you need to add 

```
Environment="CODIUS_ADMIN_API=true"
```

to your codiusd service in `/etc/systemd/system/codiusd.service`

and in the end restart the service :

```
systemctl restart codiusd
```


## Use docker-compose to manage

It is very handy to use [docker-compose][3] to manage docker containers.
You can download the binary at <https://github.com/docker/compose/releases>.

This is a sample `docker-compose.yml` file.

```yaml
version: '2'
services:
  nginx:
      container_name: Nginx
      build: nginx
      ports:
          - "8000:8000"
      depends_on:
          - "app"
      network_mode: host
      environment:
        - BASIC_AUTH_USERNAME=admin
        - BASIC_AUTH_PASSWORD=codius
        - PORT=8000

  app:
      container_name: APP
      build: app
      ports:
        - "127.0.0.1:3300:3300"
      volumes:
            - /usr/share/app
      environment:
            - MODE=prod
      network_mode: host

```

It is highly recommended that you setup a directory tree to make things easy to manage.

```bash
$ mkdir -p ~/fig/codiusd-gui
$ cd ~/fig/codiusd-gui/
$ curl -Ls  https://github.com/xrp-community/codiusd-gui-docker/archive/master.tar.gz |  tar xz --strip=1
$ docker-compose up -d
$ docker-compose ps
```

### custom port

In most cases you'll want to change a thing or two, for instance the port which the server listens on. This is done by changing the `ports` and `PORT` variable's in `nginx` section .

### custom password

Another thing you may want to change is the password. To change that, you can pass your own password as an environment variable .
change `BASIC_AUTH_USERNAME` and `BASIC_AUTH_PASSWORD`

> :warning: Click [here][2] to generate a strong password to protect your server.

## Finish

At last, open the admin page with http://your-server-ip:8000

and for `username` and `password` use `admin:codius` if you have't change it to something else .


### Contact

[<img src="https://user-images.githubusercontent.com/6250203/42041517-5435904c-7b07-11e8-906b-39a5f763a406.png" data-canonical-src="https://twitter.com/baltazar223" width="80" height="80" />
](https://twitter.com/baltazar223) 


[1]: https://github.com/codius/codiusd-gui
[2]: https://duckduckgo.com/?q=password+12&t=ffsb&ia=answer
[3]: https://github.com/docker/compose
[4]: https://docs.docker.com/
[5]: https://www.digitalocean.com/products/linux-distribution/coreos/
[6]: https://cloud.google.com/container-optimized-os/
[7]: https://docs.docker.com/install/
