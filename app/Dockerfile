FROM node:8.11.1

WORKDIR /test

COPY package.json package-lock.json /test/
RUN npm install

COPY . /test
