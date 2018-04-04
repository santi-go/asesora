# Asesora

## Start project

### Build for most users

`docker-compose build`


### Up docker

`docker-compose up`

## Launch tests

The scripts 'test-all', 'test-e2e' and 'test-unit' launch the pretest (script build) and the posttest (script linter).


### Run all test

`docker-compose run --rm node npm run test-all`

### Run end to end tests:

`docker-compose run --rm node npm run test-e2e`


### Run unit tests:

`docker-compose run --rm node npm run test-unit`

## Styles

Demo template available at `[domain::port]/demo-template/`
