#!/bin/sh
THIS_DIRECTORY=$(dirname "$0")/
. $THIS_DIRECTORY/staging-explain.sh

cd ..

explain_title

explain_abstract

first_running_test

echo "\n"

printf "${TITLE}\nRunning tests:\n${RESET}"
printf "${TEXT}· downing old test containers: ${RESET}"
docker-compose down 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}\nRising test environment...\n\n${RESET}"
docker-compose up --build -d 2>/dev/null
VALUE=$?
printf "${TEXT}\n· up test environment: ${RESET}"
print_message

printf "${TEXT}\nLaunching tests api...\n\n${RESET}"
docker-compose exec -T api sh -c "gem install bundler && bundle install && bundle exec rake test" 2>/dev/null
VALUE=$?
printf "${TEXT}· tests api: ${RESET}"
print_message

printf "${TEXT}\nLaunching tests app...\n\n${RESET}"
docker-compose run --rm app sh -c 'npm install && npm run test-all' 2>/dev/null
VALUE=$?
printf "${TEXT}\n· tests app: ${RESET}"
print_message

printf "${TEXT}· down test environment: ${RESET}"
docker-compose down 2>/dev/null
VALUE=$?
print_message


second_clean_staging

echo "\n"

printf "${TITLE}Clean staging\n${RESET}"
printf "${TEXT}· remove folder staging: ${RESET}"
rm -rf staging 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· create staging folder: ${RESET}"
mkdir staging/conf -p 2>/dev/null
VALUE=$?
print_message


third_build_architecture


printf "${TITLE}\nBuild public architecture:\n\n${RESET}"
printf "${TEXT}Building public applicative...\n${RESET}"
docker-compose run --rm app npm run build-vagrant 2>/dev/null
VALUE=$?
printf "${TEXT}\n· build app: ${RESET}"
print_message

printf "${TEXT}· containers down: ${RESET}"
docker-compose down 2>/dev/null
VALUE=$?
print_message


printf "${TITLE}\nCopy public architecture for staging:\n${RESET}"

printf "${TEXT}· copy public folder: ${RESET}"
cp app/public staging/public/ -r 2>/dev/null
VALUE=$?
print_message

printf "${TITLE}\nCopy api architecture for staging:\n${RESET}"
printf "${TEXT}· copy config.ru: ${RESET}"
cp api/config.ru staging/config.ru 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· copy Rakefile: ${RESET}"
cp api/Rakefile staging/Rakefile 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· copy asesora.rb: ${RESET}"
cp api/asesora.rb staging/asesora.rb 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· copy Gemfile: ${RESET}"
cp api/Gemfile staging/Gemfile 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· copy api system folder: ${RESET}"
cp api/system staging/system/ -r 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· copy api endpoints folder: ${RESET}"
cp api/endpoints staging/endpoints/ -r 2>/dev/null
VALUE=$?
print_message
