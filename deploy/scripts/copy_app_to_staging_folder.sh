#!/bin/sh
cd ..
cp -r app/public staging/public/
cp api/config.ru staging/config.ru
cp api/Rakefile staging/Rakefile
cp api/asesora.rb staging/asesora.rb
cp api/Gemfile staging/Gemfile
cp -r api/system staging/system/
cp -r api/endpoints staging/endpoints/
