#!/bin/sh
pause() {
   printf "\n${BLINK} → I read an error, press enter to continue\n${RESET}"
   read -p " " key
}

explain_title() {
printf "${TITLE}\n
Process to creation a 'staging' in a server
${RESET}"
}

explain_abstract() {
printf "\n
This script guide you to create and learn the process
of creation a 'staging' in a server.
It build the application and copy only needed files to folder 'staging'
and up this in an simulated server.
\n"
}

first_running_test() {
printf "${TITLE}\n
First chapter: running test
${RESET}
1. Use 'docker-compose down' to clean development environment.
2. Up the environment with 'docker-compose up --build -d'.
3. Launch api test with docker-compose exec.
4. Launch app test with docker-compose run.
5. And clean environment with 'docker-compose down'.
\n"
read -p "Press enter to run first chapter" key
}

second_clean_staging() {
printf "${TITLE}\n\n
Second chapter: clean staging for new process
${RESET}
1. Run 'docker-compose down' with '-f' to use the staging yml file
   for clean staging environment.
2. Remove folder 'staging'.
3. Create folder 'staging'.
\n"
read -p "Press enter to run second chapter" key
}

third_build_architecture() {
printf "${TITLE}\n\n
Third chapter: build public architecture to local staging
${RESET}
1. Run 'docker-compose run' with 'build-staging'
   for build app with staging environment.
2. Clean environment with 'docker-compose down'.
3. Copy folder 'app/public' to staging.
4. Copy files 'config.ru', 'Rakefile', 'asesora.rb', 'Gemfile'
   and folder 'api/system' to staging.
\n"
read -p "Press enter to run third chapter" key
}

four_launch_local() {
printf "${TITLE}\n\n
Four chapter: launching staging in local environment
${RESET}
1. Launch with docker-compose a simulation of a server
   running Debian9.4 & Ruby & Mongodb.
   This docker simulates the droplet in one service.
   The application run in localhost, where port is the default (80).
   No more services, this service contain all.
\n"
read -p "Press enter to run four chapter" key
}
