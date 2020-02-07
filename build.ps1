docker build -f ./docker/Dockerfile.build -t iqs-clients-build:1.0 .
docker run -t -d --name iqs-clients iqs-clients-build:1.0