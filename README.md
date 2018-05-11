# Asesora

## Start project

You need to install docker and docker-compose.


## Project URL

To acces the `API` use `localhost:4567`, and acces the `APP` use `localhost:8080`.


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

## Script for testing in local

For test the application configured for run without docker, view or run the script:

~~~
sh staging_local.sh
~~~

This script create a simulated service (in one docker) that reunifies all services into a machine Debian 9.4.


## Script for copy to a server

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
~~~

### Some configurations

~~~
mkdir -p /data/db
~~~

Edit ```/etc/mongodb.conf``` and configure:

~~~
bind_ip = 127.0.0.1
port = 27017
dbpath=/data/db
~~~

/etc/profile
export PATH=$PATH:/opt/rvm/bin:/opt/rvm/sbin

Update .bashrc to use rvm and create variable environment adding to ```~/.bashrc``` this:

~~~
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
export MONGODB_URI=mongodb://127.0.0.1:27017/data/db
~~~

And launch:

~~~
source ~/.bashrc
~~~

### Launch the application

Create a script that prepare ruby environment, launch mongodb and application:

~~~
nano ~/bin/launch_asesora.sh
~~~

and copy in:

~~~
#!/bin/bash --login
service mongodb stop
mongod -f /etc/mongodb.conf --fork --logpath /var/log/mongodb.log
cd /var/www/asesora
rvm use 2.5.0
bundle exec rake digitalocean
~~~

Set script executable:

~~~
chmod 755 ~/bin/launch_asesora.sh
~~~

Run the script:

~~~
sh ~/bin/launch_asesora.sh
~~~


## Ok. That's all!

When you have configured the droplet and launched the first ```staging.sh``` you only need enter with ssh in droplet and reboot it.
