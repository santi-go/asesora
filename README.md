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
chmod 600 ~/.ssh/your_key
~~~

Remember: only change the permission of the private key (this not have a _.pub_ extension).


## Copy your public key to the droplet

You need to have access rights as an administrator in order to upload your key to the server.


### With root password

~~~
cd ~/.ssh
ssh-copy-id -i your_key.pub root@ip.droplet
~~~

In this moment we urge you to indicate the password of root in droplet.


### Or, send your public key to an administrator

The administrator must copy with 'scp' the key:

~~~
scp -i admin_key -rC new_admin_user_key.pub root@206.189.1.31:/root/new_admin_user_key.pub
~~~

Then, with 'ssh', the administrator add the key to authorized keys:

~~~
ssh -i admin_key root@206.189.1.31 "cat /root/new_admin_user_key.pub >> /root/.ssh/authorized_keys"
~~~

And finally, the administrator removes the uploaded file:

~~~
ssh -i admin_key root@206.189.1.31 "rm /root/new_admin_user_key.pub"
~~~


## Connect into droplet with ssh and a public key

~~~
ssh -i ~/.ssh/your_key root@ip.droplet
~~~


# Administrar el servidor

El servidor se administra con recetas realizadas con Ansible. Todas las recetas se lanzan desde la carpeta "deploy".

Puedes probar si tienes conexión realizando la siguiente prueba:

~~~
ansible -i ./host_digitalocean digitalocean -m ping
~~~


## Instalación del servidor

Hay una receta para la creación del servidor:

~~~
ansible-playbook -i ./host_digitalocean install_server.yml
~~~


## Actualización del servidor

Para actualizar la aplicación primero debemos realizar un build y posteriormente lanzar la receta de actualización:

~~~
sh staging.sh
ansible-playbook -i ./host_digitalocean update_asesora.yml
~~~


## Mantenimiento de la base de datos

Para realizar una copia de seguridad:

~~~
ansible-playbook -i ./host_digitalocean backup_ddbb_asesora.yml
~~~

Para recuperarla:

~~~
ansible-playbook -i ./host_digitalocean restore_ddbb_asesora.yml
~~~


# Otros

Es interesante que leas la documentación de Digital Ocean respecto al uso de los servicios en Debian:

https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
