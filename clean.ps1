#!/usr/bin/env pwsh

param(
    [switch] $Full = $false
)
# Variables
. .\variables.ps1
if ($Full) {
    if (docker ps -q -a -f name=$NgContainer) {
        docker rm $NgContainer --force
    }
    if (docker ps -q -a -f name=$NgxContainer) {
        docker rm $NgxContainer --force
    }
    docker rmi $NgImage --force
    docker rmi $NgxImage --force
}
if (docker ps -q -a -f name=$ClientsContainer) {
    docker rm $ClientsContainer --force
}
docker rmi $ClientsImage --force