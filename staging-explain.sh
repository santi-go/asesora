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


#Local histories

first_create_staging_environment() {
printf "${TITLE}\n
First chapter: create a local staging environment
${RESET}
1. Creating the docker files and adding it to the gitignore.
   So if you make a mistake, the files will not be uploaded to the repository.
2. Addign a task to 'package.json'.
   With this you build the app for local staging use.
\n"
read -p "Press enter to run the first chapter" key
}

four_launch_local() {
printf "${TITLE}\n\n
Fourth chapter: launch the app in the local staging environment
${RESET}
1. Rising the local staging with the docker environment.
   Wait a moment and type 'localhost:80' in the browser.
   At this time you can use the app.
   When you have finished trying the app you have two options:
   - Use 'Ctrl+c' and break the process. So you can make corrections
     in the dockerfile file and manually raise the environment again
     as many times as you want.
     Type 'docker-compose -f docker-compose.local-staging.yml up --build'
     to build and run again.
     Then you must use 'docker-compose -f docker-compose.local-staging.yml exec asesora bash'
     to enter in container.
     If you need the changes, remember to copy them to another file to apply later to the server.
   - Or continue the process of this script. By continue the process all changes are destroyed.
2. Down the local staging environment.
\n"
read -p "Press enter to run the fourth chapter" key
}

end_remove_staging_environment() {
printf "${TITLE}\n\n
The last chapter: remove the local staging environment
${RESET}
1. Delete docker file of the local staging environment.
2. Delete docker-compose file of the local staging environment.
3. Remove task from the 'package.json'.
4. Remove dockerfiles from '.gitignore'.
\n"
read -p "Press enter to remove local environment" key
}

load_line_packagejson() {
  export INTOSCRIPT="\\\"scripts\\\"\: {"
  export NEWLINEFORPACKAGEJSON="\\n    \\\"build-staging\\\": \\\"API_HOST=localhost API_PORT=80 webpack --config conf\/webpack.config.js\\\", "
}

create_staging_files() {
cat >> .gitignore <<EOF
docker-compose.local-staging.yml
Dockerfile.local-staging
EOF

cat > Dockerfile.local-staging <<EOF
FROM ruby:2.5-stretch

RUN apt-get update && apt-get upgrade -y && apt-get install mongodb-server -yq
RUN mkdir /data/db -p
RUN chown -R mongodb:mongodb /data/db
EOF

cat > docker-compose.local-staging.yml <<EOF
version: '2'
services:
  asesora:
    build:
      context: .
      dockerfile: Dockerfile.local-staging
    environment:
      - API_HOST=localhost
      - API_PORT=80
      - MONGODB_URI=mongodb://127.0.0.1:27017/data/db
    working_dir: '/staging'
    volumes:
      - './staging/:/staging'
    ports:
      - '80:80'
    command: sh -c 'service mongodb start && gem install bundler && bundle install && rackup --port 80 -o 0.0.0.0'

volumes:
  bundle:
    driver: local
EOF
}
