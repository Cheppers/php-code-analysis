FROM ubuntu:trusty
MAINTAINER Norbert Mozsar <mozsarn@5net.hu>

# apache
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
    python-software-properties \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# php
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    unzip \
    curl \
    php7.1-cli \
    php7.1-xml \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/composer https://getcomposer.org/composer.phar && \
    chmod +x /usr/local/bin/composer && \
    composer global require "phpmd/phpmd" && \
    composer global require "phpmetrics/phpmetrics" && \
    composer global require "squizlabs/php_codesniffer" && \
    ln -s /root/.composer/vendor/bin/phpcs /usr/local/bin/phpcs && \
    ln -s /root/.composer/vendor/bin/phpmd /usr/local/bin/phpmd && \
    ln -s /root/.composer/vendor/bin/phpmetrics /usr/local/bin/phpmetrics && \
    mkdir /project

WORKDIR /project


