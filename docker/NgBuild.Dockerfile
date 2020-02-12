FROM node:8.9.4-alpine

# Install required apks
RUN apk update && apk upgrade && apk add git

# set working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# added node options to avoid js heap out of memory error
ENV NODE_OPTIONS --max_old_space_size=2048

# Copy package.json
COPY package.json package.json

# Install dependencies
RUN npm i && npm i -g gulp@3.9.1