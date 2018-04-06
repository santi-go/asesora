# Asesora

## Start project

### Build for most users

`docker-compose build`

### Build-watch

`docker-compose run --rm app npm run build-watch`


### Up docker

`docker-compose up`

If you have been done some change in js files, you have to wait for the building of bundle.js to see the changes in the application.


## Launch API tests

### Run all test of System (backend)

`docker-compose exec api rake test`


## Launch APP tests

### Run all test

`docker-compose run --rm app npm run test-all`

## Styles

Demo template available at `[domain::port]/demo-template/`
