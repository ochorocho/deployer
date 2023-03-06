ARG alpine_version=3.17
FROM alpine:${alpine_version}

# See followeing for available php versions https://pkgs.alpinelinux.org/packages?name=php8*
ARG php_version=81
ARG deployer_version=^7.2
ARG composer_version=2.5

# Install PHP + mods
RUN apk add rsync git curl php${php_version} php${php_version}-json php${php_version}-mbstring php${php_version}-openssl php81-phar php${php_version}-curl g++ make autoconf zip unzip php-zip bash && \
    # Install Composer \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --${composer_version} && \
    # Configure php.ini
    echo $'memory_limit = 1024M' >> /etc/php${php_version}/php.ini && \
    composer global require deployer/deployer "${deployer_version}" && \
    # Cleanup image
    apk del make g++ libgcc gcc binutils autoconf perl && \
    rm -rf /var/cache/apk/*

# Install Deployer
ENV PATH="/root/.composer/vendor/bin:${PATH}"
