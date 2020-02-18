# Workspace for iQuipsys Positron Client Applications

## Overview

iQuipsys Positron is an open-source IoT platform for Industrial Automation.
It is an extensible and production ready solution that comes with communication,
data storage and processing, configuration, administration and end-user tools.
To learn more about iQuipsys Positron look at https://github.com/iquipsys-positron/iqs-positron

This workspace allows quick developer's access to all iQuipsys client microapplications.

## Usage

1. Check out the workspace from GitHub

`git clone git@github.com:iquipsys-positron/iqs-positron-clients-ws`

2. Check out components
`cd iqs-positron-clients-ws`
`./checkout.ps1`

3. Build image with all components
`./build.ps1`

4. Specify server url and run clients
  4.1. First way
* Modify './docker/Nginx.Dockerfile': uncomment line #8 and set your url
* Run
`./start.ps1`
  4.2. Second way
  `docker-compose -p iqs-clients -f .\docker\docker-compose.local.yml up -d`

# Acknowledgements

iQuipsys Positron is created and maintained by iQuipsys Inc.
For any questions contact us at info@iquipsys.com
