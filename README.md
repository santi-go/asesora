# Asesora

## Start project

You need to install docker (1) and docker-compose (2). Have knowledge of ssh, as well as Ansible (3) to do the deploy.


## Project URL

To access the `API` use `localhost:4567`, and to acces the `APP` use `localhost:8080`.

## Firts start

To have a Dockerized image with a fast start, it is necessary that the installation of the packages through npm be configured in the Dockerfile; however, this configuration prevents the project from rising for the first time. Because of this, the first time we are going to build the project we will have to use a specific command:

~~~
docker-compose -f docker-compose.yml -f docker-compose.firts_start.yml up --build
~~~

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

If you are not sure if you have a public key into droplet of Digital Ocean (4), try to enter:

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
scp -i ~/.ssh/id_rsa new_admin_user_key.pub root@ip.droplet:/root/new_admin_user_key.pub
~~~

Then, with 'ssh', the administrator add the key to authorized keys:

~~~
ssh -i ~/.ssh/id_rsa root@ip.droplet "cat /root/new_admin_user_key.pub >> /root/.ssh/authorized_keys"
~~~

And finally, the administrator removes the uploaded file:

~~~
ssh -i ~/.ssh/id_rsa root@ip.droplet "rm /root/new_admin_user_key.pub"
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

If the name of the key is not the default one (~/.ssh/id_rsa) you must indicate the correct one in the file ```host_digitalocean```.


## Server installation

There is a recipe for server creation:

~~~
ansible-playbook -i ./host_digitalocean install_server.yml
~~~


## Server update

To update the application launch the update recipe:

~~~
ansible-playbook -i ./host_digitalocean build_and_update_asesora.yml
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


# Notes

(1) https://www.docker.com/

(2) https://docs.docker.com/compose/

(3) https://www.ansible.com/

(4) It is interesting that you read the Digital Ocean documentation regarding the use of services in Debian:
https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
