#!/bin/sh
THIS_DIRECTORY=$(dirname "$0")/
. $THIS_DIRECTORY/staging-explain.sh

explain_title

explain_abstract

first_running_test

echo "\n"

printf "${TITLE}\nRunning tests:\n${RESET}"
printf "${TEXT} · downing old test containers: ${RESET}"
docker-compose down 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}\nUpping test environment...\n\n${RESET}"
docker-compose up --build -d 2>/dev/null
VALUE=$?
printf "${TEXT}\n · up test environment: ${RESET}"
print_message

printf "${TEXT}\nLaunching tests api...\n\n${RESET}"
docker-compose exec -T api sh -c "gem install bundler && bundle install && bundle exec rake test" 2>/dev/null
VALUE=$?
printf "${TEXT} · tests api: ${RESET}"
print_message

printf "${TEXT}\nLaunching tests app...\n\n${RESET}"
docker-compose run --rm app sh -c 'npm install && npm run test-all' 2>/dev/null
VALUE=$?
printf "${TEXT}\n · tests app: ${RESET}"
print_message

printf "${TEXT} · down docker tests: ${RESET}"
docker-compose down 2>/dev/null
VALUE=$?
print_message


second_clean_staging

echo "\n"

printf "${TITLE}Clean staging\n${RESET}"
printf "${TEXT} · remove folder staging: ${RESET}"
rm -rf staging 2>/dev/null
VALUE=$?
print_message

printf "${TEXT} · create staging folder: ${RESET}"
mkdir staging/conf -p 2>/dev/null
VALUE=$?
print_message


third_build_architecture


printf "${TITLE}\nBuild public architecture:\n\n${RESET}"
printf "${TEXT}Building public applicative...\n${RESET}"
docker-compose run --rm app npm run build-digitalocean 2>/dev/null
VALUE=$?
printf "${TEXT}\n · build app: ${RESET}"
print_message

printf "${TEXT} · downing containers: ${RESET}"
docker-compose down 2>/dev/null
VALUE=$?
print_message


printf "${TITLE}\nCopy public architecture to staging:\n${RESET}"

printf "${TEXT} · copy public folder: ${RESET}"
cp app/public staging/public/ -r 2>/dev/null
VALUE=$?
print_message

printf "${TITLE}\nCopy api architecture to staging:\n${RESET}"
printf "${TEXT} · copy config.ru: ${RESET}"
cp api/config.ru staging/config.ru 2>/dev/null
VALUE=$?
print_message

printf "${TEXT} · copy Rakefile: ${RESET}"
cp api/Rakefile staging/Rakefile 2>/dev/null
VALUE=$?
print_message

printf "${TEXT} · copy asesora.rb: ${RESET}"
cp api/asesora.rb staging/asesora.rb 2>/dev/null
VALUE=$?
print_message

printf "${TEXT} · copy Gemfile: ${RESET}"
cp api/Gemfile staging/Gemfile 2>/dev/null
VALUE=$?
print_message

printf "${TEXT} · copy api system folder: ${RESET}"
cp api/system staging/system/ -r 2>/dev/null
VALUE=$?
print_message



four_copy_to_droplet

printf "${TITLE}\nYou need identify in ssh connections:\n\n${RESET}"
read -p "Input your ssh-private-key file with complete location: " SSHKEY
echo "\n"

printf "${TITLE}\nCreate folder 'www' in droplet:\n\n${RESET}"
ssh -i $SSHKEY root@206.189.1.31 'mkdir /var/www/ -p' 2>/dev/null
VALUE=$?
printf "${TEXT}\n · create: ${RESET}"
print_message

printf "${TITLE}\nMove folder 'asesora' to 'asesora_backup' in droplet for save:\n\n${RESET}"
ssh -i $SSHKEY root@206.189.1.31 "mkdir /var/www/asesora_backup -p" 2>/dev/null
ssh -i $SSHKEY root@206.189.1.31 "mv /var/www/asesora /var/www/asesora_backup/$(date '+%Y-%m-%d_%H:%M:%S')" 2>/dev/null
VALUE=$?
printf "${TEXT}\n · create: ${RESET}"
print_message

printf "${TITLE}\nCopy folder 'staging' to droplet:\n\n${RESET}"
scp -i $SSHKEY -rC staging/ root@206.189.1.31:/var/www/asesora/ 2>/dev/null
VALUE=$?
printf "${TEXT}\n · copying with scp (Secure Copy): ${RESET}"
print_message
