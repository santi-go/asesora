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
4. Copy the files 'config.ru', 'Rakefile', 'asesora.rb', 'Gemfile'
   and folder 'api/system' to 'staging'.
   \n"
read -p "Press enter to run the third chapter" key
}

third_add_fixture() {
printf "\n5. Copy the file 'config.dev.ru' and folder 'prepare_staging' to 'staging'.
   We asked if you want to copy the staging fixture:
   - If you answer ${GREEN}'y'${RESET} the fixture will be copied,
     the data from the staging database will be deleted
     and initialized with those of the fixture.
   - If you answer ${GREEN}'n'${RESET} the existing data in staging will not be modified.
\n"
}

four_copy_to_droplet() {
printf "${TITLE}\n\n
Fourth chapter: copy the application to the droplet
${RESET}
1. You need to input your ssh-private-key file
   (enter the key with its complete location).
   example: '~/.ssh/my_ssh'
2. Create a folder '/var/www' in the droplet.
   This will not destruct any other files or folders.
3. We will create a backup of the older application
   using the ssh connection.
4. Copy the folder 'staging' directly to the folder 'asesora' in the droplet.
\n"
read -p "Press enter to run the fourth chapter" key
}
