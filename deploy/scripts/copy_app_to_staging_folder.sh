#!/bin/sh
cd ..
cp app/public staging/public/ -r
cp api/config.ru staging/config.ru
cp api/Rakefile staging/Rakefile
cp api/asesora.rb staging/asesora.rb
cp api/Gemfile staging/Gemfile
cp api/system staging/system/ -r
cp api/endpoints staging/endpoints/ -r
