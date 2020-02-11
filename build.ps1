docker build -f ./docker/Dockerfile.build -t iqs-clients-build:1.0 .
docker run -t -d --name iqs-clients-build iqs-clients-build:1.0
# docker cp iqs-clients-build:/tmp/ws/dist/ ./dist/