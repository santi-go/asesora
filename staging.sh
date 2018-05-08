#!/bin/bash

rm -rf staging
mkdir staging -p

docker-compose run --rm app npm run build

cp app/public staging/public/ -r
cp api/asesora.rb staging/asesora.rb
cp api/Gemfile staging/Gemfile
cp api/system staging/system/ -r

docker build staging -f Dockerfile.staging
