FROM ubuntu:20.04
MAINTAINER Norbert Mozsar <norbert.mozsar@cheppers.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
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
    php7.4-cli \
    php7.4-xml \
    php7.4-mbstring \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/composer https://getcomposer.org/composer.phar && \
    chmod +x /usr/local/bin/composer && \
    composer global require "phpmd/phpmd" && \
    composer global require "phpmetrics/phpmetrics" && \
    composer global require "squizlabs/php_codesniffer=*" && \
    composer global require "drupal/coder" && \
    ln -s /root/.config/composer/vendor/bin/phpcs /usr/local/bin/phpcs && \
    ln -s /root/.config/composer/vendor/bin/phpcbf /usr/local/bin/phpcbf && \
    ln -s /root/.config/composer/vendor/bin/phpmd /usr/local/bin/phpmd && \
    ln -s /root/.config/composer/vendor/bin/phpmetrics /usr/local/bin/phpmetrics && \
    phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer && \
    curl -L -o /usr/local/bin/php-security-checker https://github.com/fabpot/local-php-security-checker/releases/download/v1.0.0/local-php-security-checker_1.0.0_linux_amd64 && \
    chmod +x /usr/local/bin/php-security-checker && \
    mkdir /project

COPY files/pathreplace.sh /pathreplace.sh
RUN chmod +x /pathreplace.sh && \
    phpcs -i

WORKDIR /project
