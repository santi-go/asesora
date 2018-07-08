#!/bin/sh
BLINK='\033[5m'
RED='\033[1;31m'
GREEN='\033[1;32m'
TITLE='\033[1;35m'
TEXT='\033[1;34m'
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
   printf "\n${BLINK} → An error appeared, press enter to continue or cancel with 'Ctrl + c'\n${RESET}"
   read -p " " key
}

explain_title() {
printf "${TITLE}\n
Process of the creation of the 'staging' in the server
${RESET}"
}

explain_abstract() {
printf "\n
This script will guide you in the creation and learning of the process
of the creation of the 'staging' in the server.
We will build the application and copy only the needed files to the folder 'staging'.
Then we will copy the 'staging' into the droplet.
\n"
}

first_running_test() {
printf "${TITLE}\n
First chapter: running tests
${RESET}
1. Use the 'docker-compose down' command to clean the development environment.
2. Rise the environment with 'docker-compose up --build -d'.
3. Launch api test with 'docker-compose exec'.
4. Launch app test with 'docker-compose run'.
5. Then clean the environment with 'docker-compose down'.
\n"
read -p "Press enter to run the first chapter" key
}

second_clean_staging() {
printf "${TITLE}\n\n
Second chapter: clean staging for a new process
${RESET}
1. Remove the folder 'staging'.
2. Create a folder 'staging'.
\n"
read -p "Press enter to run the second chapter" key
}

third_build_architecture() {
printf "${TITLE}\n\n
Third chapter: build a public architecture staging
${RESET}
1. Run the command 'docker-compose run' with 'build-staging'
   to build the app.
2. Clean the environment with 'docker-compose down'.
3. Copy the folder 'app/public' to 'staging'.
4. Copy the files 'config.ru', 'Rakefile', 'asesora.rb', 'Gemfile',
   folder 'api/endpoints' and folder 'api/system' to 'staging'.
   \n"
read -p "Press enter to run the third chapter" key
}
