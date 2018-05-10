#!/bin/sh
BLINK='\033[5m'
RED='\033[1;31m'
GREEN='\033[1;32m'
RESET='\033[0m'
pause() {
   printf "\n${BLINK} → Press enter to continue${RESET}"
   read -p " " key
   echo "\n"
}

echo "\n\n\n"

printf "${GREEN}Clean staging\n${RESET}"
printf " · downing old staging containers: "
docker-compose -f docker-compose_staging.yml down 2>/dev/null
DOCKER_STAGING_DOWN=$?
if [ $DOCKER_STAGING_DOWN -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "${RED}Error ${DOCKER_STAGING_DOWN}${RESET}\n"
   pause
fi

printf " · remove folder staging: "
rm -rf staging 2>/dev/null
REMOVE_STAGING_FOLDER=$?
if [ $REMOVE_STAGING_FOLDER -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${REMOVE_STAGING_FOLDER}${RESET}\n"
   pause
fi

printf " · create staging folder: "
mkdir staging/conf -p 2>/dev/null
CREATE_STAGING_FOLDER=$?
if [ $CREATE_STAGING_FOLDER -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${CREATE_STAGING_FOLDER}${RESET}\n"
   pause
fi


printf "${GREEN}\nRunning tests:\n\n${RESET}"
printf " · launching tests app...\n"
docker-compose run --rm app npm run test-all 2>/dev/null
TEST_APP=$?
if [ $TEST_APP -eq 0 ];then
   printf " · tests app: ${GREEN}Ok${RESET}\n"
else
   printf "\n${RED} · tests app: Error ${TEST_APP}${RESET}\n"
   pause
fi

printf " · launching tests api...\n"
echo "\n"
docker-compose run --rm api sh -c "gem install bundler && bundle install && bundle exec rake test" 2>/dev/null
TEST_API=$?
if [ $TEST_API -eq 0 ];then
   printf " · tests api: ${GREEN}Ok${RESET}\n"
else
   printf "\n${RED} · tests api: Error ${TEST_API}${RESET}\n"
   pause
fi

printf " · down docker tests: "
docker-compose down 2>/dev/null
DOCKER_TESTING_DOWN=$?
if [ $DOCKER_TESTING_DOWN -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${DOCKER_TESTING_DOWN}${RESET}\n"
   pause
fi


printf "${GREEN}\nBuild public architecture:\n\n${RESET}"
printf " · building public applicative...\n"
docker-compose run --rm app npm run build 2>/dev/null
echo "\n"
BUILD_APP=$?
if [ $BUILD_APP -eq 0 ];then
   printf " · build public applicative: ${GREEN}Ok${RESET}\n"
else
   printf "\n${RED} · build public applicative: Error ${BUILD_APP}${RESET}\n"
   pause
fi

printf " · remove container app: "
docker-compose down 2>/dev/null
REMOVE_CONTAINER_APP=$?
if [ $REMOVE_CONTAINER_APP -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${REMOVE_CONTAINER_APP}${RESET}\n"
   pause
fi

printf "${GREEN}\nCopy public architecture to staging:\n${RESET}"
printf " · copy public folder: "
cp app/public staging/public/ -r 2>/dev/null
COPY_PUBLIC_FOLDER=$?
if [ $COPY_PUBLIC_FOLDER -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${COPY_PUBLIC_FOLDER}${RESET}\n"
   pause
fi

printf "${GREEN}\nCopy api architecture to staging:\n${RESET}"
printf " · copy config.ru: "
cp api/config.ru staging/config.ru 2>/dev/null
COPY_CONFIGRU=$?
if [ $COPY_CONFIGRU -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${COPY_CONFIGRU}${RESET}\n"
   pause
fi

printf " · copy Rakefile: "
cp api/Rakefile staging/Rakefile 2>/dev/null
COPY_RAKEFILE=$?
if [ $COPY_RAKEFILE -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${COPY_RAKEFILE}${RESET}\n"
   pause
fi

printf " · copy asesora.rb: "
cp api/asesora.rb staging/asesora.rb 2>/dev/null
COPY_ASESORARB=$?
if [ $COPY_ASESORARB -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${COPY_ASESORARB}${RESET}\n"
   pause
fi

printf " · copy Gemfile: "
cp api/Gemfile staging/Gemfile 2>/dev/null
COPY_GEMFILE=$?
if [ $COPY_GEMFILE -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${COPY_GEMFILE}${RESET}\n"
   pause
fi

printf " · copy system: "
cp api/system staging/system/ -r 2>/dev/null
COPY_SYSTEM=$?
if [ $COPY_SYSTEM -eq 0 ];then
   printf "${GREEN}Ok${RESET}\n"
else
   printf "\n${RED}Error ${COPY_SYSTEM}${RESET}\n"
   pause
fi

printf "${GREEN}\nLaunching staging in local environment:\n${RESET}"
echo "\n"
docker-compose -f docker-compose_staging.yml up --build -d 2>/dev/null
UPPING_STAGING=$?
if [ $UPPING_STAGING -eq 0 ];then
   printf " · upping staging: ${GREEN}Ok${RESET}\n"
else
   printf "\n${RED} · upping staging: Error ${UPPING_STAGING}${RESET}\n"
   pause
fi

echo "${GREEN}\n\n${BLINKING}Enter in localhost to view the staging running!${RESET}"
