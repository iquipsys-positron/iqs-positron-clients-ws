FROM node:10.15.3-alpine

# Install required apks
RUN apk update && apk upgrade && apk add git

# added node options to avoid js heap out of memory error
ENV NODE_OPTIONS --max_old_space_size=2048

# set working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app