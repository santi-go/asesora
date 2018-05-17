# Asesora

## Start project

You need to install docker and docker-compose.


## Project URL

To access the `API` use `localhost:4567`, and acces the `APP` use `localhost:8080`.


### Up docker

`docker-compose up`


## Launch API tests

### Run all test of System (backend)

`docker-compose exec api rake test`


## Launch APP tests

First you need to prepare the project with `npm install`. This is automatic if you run docker with `docker-compose up`.

Before launch the test you have to build the application with `docker-compose run --rm app npm run build` or with a watcher using `docker-compose run --rm app npm run build-watch`.


### Build-watch

`docker-compose run --rm app npm run build-watch`


### Run all test

`docker-compose run --rm app npm run test-all`


## Styles

Demo template available at the project in folder `/app/demo-template`


# Staging

If you are not sure if you have a public key into droplet of Digital Ocean, try to enter:

~~~
ssh root@ip.droplet
~~~

This create a .ssh folder and know_hosts in your computer (client side).

Or you try to create the folder with:

~~~
mkdir ~/.ssh
~~~


## Create new key for enter with ssh

Enter in the .ssh folder and create a new pair of keys (public and private) for ssh connection to droplet:

~~~
cd ~/.ssh
ssh-keygen -t rsa
~~~

And change de permission of the folder and file:

~~~
chmod 700 ~/.ssh
chmod 600 ~/.ssh/your_key
~~~

Remember: only change the permission of the private key (this not have a _.pub_ extension).


## Copy your public key to the droplet

~~~
cd ~/.ssh
ssh-copy-id -i your_key.pub root@ip.droplet
~~~

In this moment we urge you to indicate the root password of root in droplet.


## Finally, connect into droplet with ssh

~~~
ssh -i ~/.ssh/your_key root@ip.droplet
~~~


# The server

## Script for deploy to a server

For copy the applicative to a server, view or run the script:

~~~
sh staging.sh
~~~


## The droplet in Digital Ocean

### Installation

You need first prepare the server, install Mongodb. With a root user:

~~~
apt-get update
apt-get upgrade
apt-get install mongodb-server curl
~~~

Rvm, ruby and bundler:

~~~
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
\curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer
\curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc
gpg --verify rvm-installer.asc
bash rvm-installer stable
rvm install 2.5.0
rvm gemset use global && gem install bundler
rm rvm-installer
rm rvm-installer.asc
~~~

### Some configurations

Update .bashrc to use rvm and create variable environment adding to ```~/.bashrc``` this:

~~~
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
export API_HOST='206.189.1.31'
export MONGODB_URI=mongodb://127.0.0.1:27017/data/db
~~~

And launch:

~~~
source ~/.bashrc
~~~

### Prepare Mongodb

Create directory for databases:

~~~
mkdir -p /data/db
chown -R mongodb:mongodb /data/db
~~~

Edit ```/etc/mongodb.conf``` and configure:

~~~
bind_ip = 127.0.0.1
port = 27017
dbpath=/data/db
~~~

Reboot system:

~~~
reboot
~~~


### Launch the application

Create a script that prepare ruby environment and launch application:

~~~
nano ~/bin/launch_asesora.sh
~~~

and copy in:

~~~
#!/bin/bash --login
cd /var/www/asesora
rvm use 2.5.0
bundle exec rake digitalocean
~~~

Set script executable:

~~~
chmod 755 ~/bin/launch_asesora.sh
~~~

Add to crontab:

~~~
crontab -e
~~~

Add to end the next line:

~~~
@reboot /root/bin/launch_asesora.sh
~~~


# Proof environment

If you will prepare a proof environment before install, remove or update programs in the droplet server, run this:

~~~
sh staging-local.sh
~~~

it creates a staging docker in local for proof and testing.

By this you have a 'Dockerfile.local-staging' for yours proofs. You run manually with a "docker-compose -f docker-compose.local-staging.yml up --build".

When the script finish, it remove testing environment and all created files.
