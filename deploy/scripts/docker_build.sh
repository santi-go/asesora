#!/bin/sh
cd ..
docker-compose down
docker-compose run --rm app npm run build-digitalocean
docker-compose down
