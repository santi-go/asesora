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


## After performing the tests

When you launch the test your system link looks to `api` container, so your 'api' is not launched in localhost.

If you need view the application in a web navigator run the build again:

~~~
docker-compose run --rm app npm run build
~~~


# Templates

## Styles

Demo template available at the project in folder `/app/templates/medialot`

## Favicon

Template in format svg at `/app/templates/favicon`


# Connect with the server

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
chmod 600 ~/.ssh/id_rsa
~~~

Remember: only change the permission of the private key (this not have a _.pub_ extension).


## Copy your public key to the droplet

You need to have access rights as an administrator in order to upload your key to the server.


### With root password

~~~
cd ~/.ssh
ssh-copy-id -i ~/.ssh/id_rsa root@ip.droplet
~~~

In this moment we urge you to indicate the password of root in droplet.


### Or, send your public key to an administrator

The administrator must copy with 'scp' the key:

~~~
scp -i ~/.ssh/id_rsa -rC new_admin_user_key.pub root@206.189.1.31:/root/new_admin_user_key.pub
~~~

Then, with 'ssh', the administrator add the key to authorized keys:

~~~
ssh -i ~/.ssh/id_rsa root@206.189.1.31 "cat /root/new_admin_user_key.pub >> /root/.ssh/authorized_keys"
~~~

And finally, the administrator removes the uploaded file:

~~~
ssh -i ~/.ssh/id_rsa root@206.189.1.31 "rm /root/new_admin_user_key.pub"
~~~


## Connect into droplet with ssh and a public key

~~~
ssh -i ~/.ssh/id_rsa root@ip.droplet
~~~


# Manage the server

The server is managed with recipes made with Ansible. All recipes are launched from the "deploy" folder.

You can test if you have a connection by performing the following test:

~~~
ansible -i ./host_digitalocean digitalocean -m ping
~~~

If the name of the key is not the default one (~ / .ssh / id_rsa) you must indicate the correct one in the file ```host_digitalocean```.


## Server installation

There is a recipe for server creation:

~~~
ansible-playbook -i ./host_digitalocean install_server.yml
~~~


## Server update

To update the application we must first perform a build and then launch the update recipe:

~~~
sh build_staging.sh
ansible-playbook -i ./host_digitalocean update_asesora.yml
~~~


## Data base maintenance

To make a backup:

~~~
ansible-playbook -i ./host_digitalocean backup_ddbb_asesora.yml
~~~

To recover it:

~~~
ansible-playbook -i ./host_digitalocean restore_ddbb_asesora.yml
~~~


# Others

It is interesting that you read the Digital Ocean documentation regarding the use of services in Debian:

https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
