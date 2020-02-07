FROM ubuntu:16.04

# Define ENVs for Localization/Globalization
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    # set a fixed location for the Module analysis cache
    PSModuleAnalysisCachePath=/var/cache/microsoft/powershell/PSModuleAnalysisCache/ModuleAnalysisCache \
    PS_PACKAGE_URL=https://github.com/PowerShell/PowerShell/releases/download/v6.2.0/powershell_6.2.0-1.ubuntu.16.04_amd64.deb

# Switch to bash
SHELL ["/bin/bash", "-c"]
# Install dependencies and clean up
RUN apt-get update \
    && apt-get install -y \
    # curl is required to grab the Linux package
        curl \
    # less is required for help in powershell
        less \
    # requied to setup the locale
        locales \
    # required for SSL
        ca-certificates \
        gss-ntlmssp \
    # reuired for development
        git build-essential libssl-dev \
    # Download the Linux package and save it
    && echo $PS_PACKAGE_URL \
    && curl -sSL $PS_PACKAGE_URL -o /tmp/powershell.deb \
    && apt-get install -y /tmp/powershell.deb \
    && apt-get dist-upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen $LANG && update-locale \
    # remove powershell package
    && rm /tmp/powershell.deb \
    # intialize powershell module cache
    && pwsh \
        -NoLogo \
        -NoProfile \
        -Command " \
          \$ErrorActionPreference = 'Stop' ; \
          \$ProgressPreference = 'SilentlyContinue' ; \
          while(!(Test-Path -Path \$env:PSModuleAnalysisCachePath)) {  \
            Write-Host "'Waiting for $env:PSModuleAnalysisCachePath'" ; \
            Start-Sleep -Seconds 6 ; \
          }" \
    # Install nvm
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh -o /tmp/install_nvm.sh \
    && bash ./tmp/install_nvm.sh \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
    && rm -rf /tmp/install_nvm.sh \
    && nvm install 10.15.3 && nvm install 8.9.4

# Install pip-tasks
RUN git clone https://github.com/pip-tasks/pip-tasks-ws.git \
    && cd pip-tasks-ws \
    && git clone https://github.com/pip-tasks/pip-tasks.git \
    && git clone https://github.com/pip-tasks/pip-tasks-common.git \
    && git clone https://github.com/pip-tasks/pip-tasks-dotnet.git \
    && git clone https://github.com/pip-tasks/pip-tasks-java.git \
    && git clone https://github.com/pip-tasks/pip-tasks-js.git \
    && git clone https://github.com/pip-tasks/pip-tasks-python.git \
    && git clone https://github.com/pip-tasks/pip-tasks-all.git \
    && cd .. \
    && mv ./pip-tasks-ws /usr/local/share/powershell/Modules
SHELL ["pwsh"]
RUN Import-Module pip-tasks-common; Import-Module pip-tasks-js
# Clone iqs-positron-clients-ws
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts; \
    git clone https://github.com/iquipsys-positron/iqs-positron-clients-ws.git /tmp/iqs-positron-clients-ws; \
    cd /tmp/iqs-positron-clients-ws; \
    git checkout dev; \
    ./checkout.ps1
SHELL ["bash"]
RUN nvm use 8.9.4 \

# Switch node
# Build old applications
# Switch node
# Build new applications
# Gather

# Clone repository
# RUN cd home/ && git clone https://github.com/iquipsys-positron/iqs-positron-clients-ws.git

# # Copy local ssh keys
# COPY docker/id_rsa /root/.ssh/

# # Setup ssh access to git repositories
# RUN chmod 600 /root/.ssh/id_rsa* \
#     && ssh-keyscan github.com >> ~/.ssh/known_hosts \
#     && ssh-keyscan gitlab.com >> ~/.ssh/known_hosts

# # Set working directory
# WORKDIR /app

# # Copy project file
# COPY package.json .

# # Install only production dependencies
# #RUN npm install --only=production
# RUN npm install

# # Copy the entire project
# COPY . .

# # Set default environment variables
# ##

# EXPOSE 8080

# CMD [ "pwsh" ]