#!/bin/bash

echo 'Clean staging'
docker-compose -f docker-compose_staging.yml down 2>/dev/null
DOCKER_STAGING_DOWN=$?
if [ $DOCKER_STAGING_DOWN -eq 0 ];then
   echo ' · downing old containers: Ok'
else
   echo ' · downing old containers: Error ' $DOCKER_STAGING_DOWN
fi

rm -rf staging 2>/dev/null
REMOVE_STAGING_FOLDER=$?
if [ $REMOVE_STAGING_FOLDER -eq 0 ];then
   echo ' · remove folder staging: Ok'
else
   echo ' · remove folder staging: Error ' $REMOVE_STAGING_FOLDER
fi

mkdir staging/conf -p 2>/dev/null
CREATE_STAGING_FOLDER=$?
if [ $CREATE_STAGING_FOLDER -eq 0 ];then
   echo ' · create staging folder: Ok'
else
   echo ' · create staging folder: Error ' $CREATE_STAGING_FOLDER
fi

echo '\nBuild public architecture:'
docker-compose run --rm app npm run build 2>/dev/null
BUILD_APP=$?
if [ $BUILD_APP -eq 0 ];then
   echo ' · build public applicative: Ok'
else
   echo ' · remove folder staging: Error ' $BUILD_APP
fi

docker-compose down 2>/dev/null
REMOVE_CONTAINER_APP=$?
if [ $REMOVE_CONTAINER_APP -eq 0 ];then
   echo ' · remove container app: Ok'
else
   echo ' · remove container app: Error ' $REMOVE_CONTAINER_APP
fi

echo '\nCopy public architecture to staging:'
cp app/conf/nginx.conf staging/conf/nginx.conf 2>/dev/null
COPY_NGINX=$?
if [ $COPY_NGINX -eq 0 ];then
   echo ' · copy NGINX conf: Ok'
else
   echo ' · copy NGINX conf: Error ' $COPY_NGINX
fi

cp app/public staging/public/ -r 2>/dev/null
COPY_PUBLIC_FOLDER=$?
if [ $COPY_PUBLIC_FOLDER -eq 0 ];then
   echo ' · copy public folder: Ok'
else
   echo ' · copy public folder: Error ' $COPY_PUBLIC_FOLDER
fi

echo '\nCopy api architecture to staging:'
cp api/config.ru staging/config.ru 2>/dev/null
COPY_CONFIGRU=$?
if [ $COPY_CONFIGRU -eq 0 ];then
   echo ' · copy config.ru: Ok'
else
   echo ' · copy config.ru: Error ' $COPY_CONFIGRU
fi

cp api/Rakefile staging/Rakefile 2>/dev/null
COPY_RAKEFILE=$?
if [ $COPY_RAKEFILE -eq 0 ];then
   echo ' · copy Rakefile: Ok'
else
   echo ' · copy Rakefile: Error ' $COPY_RAKEFILE
fi

cp api/asesora.rb staging/asesora.rb 2>/dev/null
COPY_ASESORARB=$?
if [ $COPY_ASESORARB -eq 0 ];then
   echo ' · copy asesora.rb: Ok'
else
   echo ' · copy asesora.rb: Error ' $COPY_ASESORARB
fi

cp api/Gemfile staging/Gemfile 2>/dev/null
COPY_GEMFILE=$?
if [ $COPY_GEMFILE -eq 0 ];then
   echo ' · copy Gemfile: Ok'
else
   echo ' · copy Gemfile: Error ' $COPY_GEMFILE
fi

cp api/system staging/system/ -r 2>/dev/null
COPY_SYSTEM=$?
if [ $COPY_SYSTEM -eq 0 ];then
   echo ' · copy system: Ok'
else
   echo ' · copy system: Error ' $COPY_SYSTEM
fi

echo '\nLaunching staging:'
docker-compose -f docker-compose_staging.yml up --build 2>/dev/null
UPPING_STAGING=$?
if [ $UPPING_STAGING -eq 0 ];then
   echo ' · upping staging: Ok'
else
   echo ' · upping staging: Error ' $UPPING_STAGING
fi
