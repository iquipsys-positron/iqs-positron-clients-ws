docker build -f ./docker/Dockerfile -t iqs-clients:1.0 .
docker run -t -d -p 8080:80 --name iqs-clients iqs-clients:1.0