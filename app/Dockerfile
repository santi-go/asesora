FROM node:8.11.1

ENV API_HOST api
ENV API_PORT 4567

WORKDIR /test

COPY package.json package-lock.json /test/
RUN npm install

COPY . /test
