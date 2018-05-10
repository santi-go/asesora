#!/bin/sh
BLINK='\033[5m'
RED='\033[1;31m'
GREEN='\033[1;32m'
TITLE='\033[1;35m'
RESET='\033[0m'
print_message() {
  if [ $VALUE -eq 0 ];then
     printf "${GREEN}Ok${RESET}\n"
  else
     printf "${RED}Error ${VALUE}${RESET}\n"
     pause
  fi
}
pause() {
   printf "\n${BLINK} → Press enter to continue\n${RESET}"
   read -p " " key
}

echo "\n"

printf "${TITLE}Clean staging\n${RESET}"
printf " · downing old staging containers: "
docker-compose -f docker-compose_staging.yml down 2>/dev/null
VALUE=$?
print_message

printf " · remove folder staging: "
rm -rf staging 2>/dev/null
VALUE=$?
print_message

printf " · create staging folder: "
mkdir staging/conf -p 2>/dev/null
VALUE=$?
print_message


printf "${TITLE}\nRunning tests:\n\n${RESET}"
printf " · launching tests app...\n"
docker-compose run --rm app npm run test-all 2>/dev/null
VALUE=$?
printf "\n · tests app: "
print_message

printf "\n · launching tests api...\n"
docker-compose run --rm api sh -c "gem install bundler && bundle install && bundle exec rake test" 2>/dev/null
VALUE=$?
printf " · tests api: "
print_message

printf " · down docker tests: "
docker-compose down 2>/dev/null
VALUE=$?
print_message

printf "${TITLE}\nBuild public architecture:\n\n${RESET}"
printf " · building public applicative...\n"
docker-compose run --rm app npm run build-staging 2>/dev/null
VALUE=$?
printf "\n · build app: "
print_message

printf " · remove container app: "
docker-compose down 2>/dev/null
VALUE=$?
print_message


printf "${TITLE}\nCopy public architecture to staging:\n${RESET}"

printf " · copy public folder: "
cp app/public staging/public/ -r 2>/dev/null
VALUE=$?
print_message

printf "${TITLE}\nCopy api architecture to staging:\n${RESET}"
printf " · copy config.ru: "
cp api/config.ru staging/config.ru 2>/dev/null
VALUE=$?
print_message

printf " · copy Rakefile: "
cp api/Rakefile staging/Rakefile 2>/dev/null
VALUE=$?
print_message

printf " · copy asesora.rb: "
cp api/asesora.rb staging/asesora.rb 2>/dev/null
VALUE=$?
print_message

printf " · copy Gemfile: "
cp api/Gemfile staging/Gemfile 2>/dev/null
VALUE=$?
print_message

printf " · copy system: "
cp api/system staging/system/ -r 2>/dev/null
VALUE=$?
print_message

printf "${TITLE}\nLaunching staging in local environment:\n${RESET}"
docker-compose -f docker-compose_staging.yml up --build -d 2>/dev/null
VALUE=$?
printf "\n · launched staging in local environment: "
print_message

echo "${GREEN}\n\nEnter in localhost to view the staging running!${RESET}"
