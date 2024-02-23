# DDEV Base Image
FROM ddev/ddev-webserver:v1.22.7

# Correct Timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

#FIX
RUN apt-get update && apt-get install -y apt-transport-https lsb-release ca-certificates curl gnupg
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg

# Install this versions
ENV NODE_MAJOR=20
ENV NPM_VERSION=^10
ENV SASS_VERSION=^1

# Install NodeJS
RUN (apt-get remove -y nodejs || true) && (apt purge nodejs || true)
RUN sudo mkdir /etc/apt/keyrings && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
RUN sudo apt-get update && sudo apt-get install nodejs -y

# Install node + npm + ncu + sass
RUN npm install -g npm@${NPM_VERSION}
RUN npm install -g npm-check-updates
RUN npm install -g sass@${SASS_VERSION}
RUN npm install -g turbo