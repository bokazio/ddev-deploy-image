# DDEV Base Image
FROM drud/ddev-webserver:v1.21.4

# Correct Timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

#FIX
RUN apt install apt-transport-https lsb-release ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg

# Install whatever nodejs version you want
ENV NODE_VERSION=14
ENV NPM_VERSION=9.4.0
ENV SASS_VERSION=1.57.1
ENV CROSSENV_VERSION=7.0.3

RUN apt remove -y nodejs
RUN curl -sSL --fail https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y -o Dpkg::Options::="--force-confold" --no-install-recommends --no-install-suggests nodejs build-essential
RUN npm install --global npm@${NPM_VERSION}
RUN npm install --global cross-env@${CROSSENV_VERSION}
RUN npm install --global grunt
RUN npm install --global gulp-cli
RUN npm install --global npm-check-updates

# Install DART Sass
RUN wget -O /tmp/sass.tar.gz https://github.com/sass/dart-sass/releases/download/${SASS_VERSION}/dart-sass-${SASS_VERSION}-linux-x64.tar.gz
RUN tar xfvz /tmp/sass.tar.gz -C /tmp
RUN mv /tmp/dart-sass/sass /usr/local/bin/sass
RUN chmod +x /usr/local/bin/sass
RUN rm -rf /tmp/dart-sass
