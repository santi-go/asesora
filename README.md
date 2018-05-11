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
