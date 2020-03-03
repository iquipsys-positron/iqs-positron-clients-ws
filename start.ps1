#!/usr/bin/env pwsh

# Variables
. .\variables.ps1

docker run -d -t -p 80:80 --name $ClientsContainer ${ClientsImage}