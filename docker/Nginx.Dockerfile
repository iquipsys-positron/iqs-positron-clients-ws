FROM nginx:alpine

# Install dependencies
RUN apk add bash jq
SHELL ["/bin/bash", "-c"]

# Set server Url
# ENV IQS_SERVER_URL "http://192.168.99.100:8080"

# set working directory
WORKDIR /usr/share/nginx/html

COPY dist .
COPY docker/configure.sh ../configure.sh

EXPOSE 80
ENTRYPOINT ../configure.sh && nginx -g 'daemon off;'