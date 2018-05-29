#!/bin/sh
THIS_DIRECTORY=$(dirname "$0")/
. $THIS_DIRECTORY/staging-explain.sh

explain_title

explain_abstract

first_create_staging_environment

printf "${TITLE}\nCreate a local staging environment\n${RESET}"
printf "${TEXT}· creating the docker files and adding it to the gitignore: ${RESET}"
create_staging_files 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· adding a task to package.json: ${RESET}"
load_line_packagejson
sed -i -e 's/'"$INTOSCRIPT"'/'"$INTOSCRIPT${NEWLINEFORPACKAGEJSON}"'/g' app/package.json 2>/dev/null
VALUE=$?
print_message


second_clean_staging

echo "\n"

printf "${TITLE}Clean staging\n${RESET}"
printf "${TEXT}· downing old staging containers: ${RESET}"
docker-compose -f docker-compose.local-staging.yml down 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· remove folder staging: ${RESET}"
rm -rf staging 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· create staging folder: ${RESET}"
mkdir staging/conf -p 2>/dev/null
VALUE=$?
print_message


third_build_architecture

printf "${TITLE}\nBuild public architecture:\n${RESET}"
printf "${TEXT}· downing old containers: ${RESET}"
docker-compose down 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}\nBuilding public applicative...\n${RESET}"
docker-compose run --rm app npm run build-staging 2>/dev/null
VALUE=$?
printf "${TEXT}\n· build app: ${RESET}"
print_message

printf "${TEXT}· downing containers: ${RESET}"
docker-compose down 2>/dev/null
VALUE=$?
print_message


printf "${TITLE}\nCopy public architecture to staging:\n${RESET}"

printf "${TEXT}· copy public folder: ${RESET}"
cp app/public staging/public/ -r 2>/dev/null
VALUE=$?
print_message

printf "${TITLE}\nCopy api architecture to staging:\n${RESET}"
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

printf "${TEXT}· create fixture folder: ${RESET}"
mkdir staging/spec/fixtures/ -p 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· copy staging fixture: ${RESET}"
cp api/spec/prepare_staging/fixtures.rb staging/spec/fixtures/fixtures.rb 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· copy staging spec: ${RESET}"
cp api/spec/prepare_staging/spec_staging.rb staging/spec/staging_spec.rb 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· copy config.dev.ru: ${RESET}"
cp api/config.dev.ru staging/. 2>/dev/null
VALUE=$?
print_message



four_launch_local


printf "${TITLE}\nLaunching staging in local environment:\n\n${RESET}"
docker-compose -f docker-compose.local-staging.yml up --build -d 2>/dev/null
VALUE=$?
printf "${TEXT}\n· launched staging in local environment: ${RESET}"
print_message

echo "${GREEN}\n\nVisit 'localhost:80' to view the staging running!${RESET}"

printf "${TITLE}\n\nHave you finished the tests?${RESET}"
printf "${TITLE}\nYou would down staging from local environment?\n${RESET}"
read -p "(enter to continue)" key
docker-compose -f docker-compose.local-staging.yml down 2>/dev/null
VALUE=$?
printf "${TEXT}\n· down staging from local environment: ${RESET}"
print_message


end_remove_staging_environment

printf "${TITLE}\n\nRemoving staging in local environment:\n${RESET}"

printf "${TEXT}· Delete Dockerfile: ${RESET}"
rm Dockerfile.local-staging 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· Delete docker-compose file: ${RESET}"
rm docker-compose.local-staging.yml 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· Delete task from package.json: ${RESET}"
load_line_packagejson
sed -i '/build-staging/d' app/package.json 2>/dev/null
VALUE=$?
print_message

printf "${TEXT}· Remove docker files from gitignore: ${RESET}"
sed -i '/local-staging/d' .gitignore 2>/dev/null
VALUE=$?
print_message
