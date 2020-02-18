FROM nginx:alpine

# Install dependencies
RUN apk add bash jq
SHELL ["/bin/bash", "-c"]

# set working directory
WORKDIR /usr/share/nginx/html

COPY dist .
COPY docker/configure.sh ../configure.sh

EXPOSE 80
ENTRYPOINT ../configure.sh && /bin/bash