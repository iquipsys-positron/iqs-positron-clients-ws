# Variables
. .\variables.ps1
if (docker ps -q -a -f name=$NgContainer) {
    docker rm $NgContainer --force
}
if (docker ps -q -a -f name=$NgxContainer) {
    docker rm $NgxContainer --force
}
if (docker ps -q -a -f name=$ClientsContainer) {
    docker rm $ClientsContainer --force
}
docker rmi $NgImage --force
docker rmi $NgxImage --force
docker rmi $ClientsImage --force