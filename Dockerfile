FROM alpine:3.15

# Install PHP + mods
RUN apk --update --no-cache --update-cache --allow-untrusted add \
    git curl php8 php8-json php8-mbstring php8-openssl php8-phar g++ make autoconf zip unzip php-zip && \
    ln -sfn /usr/bin/php8 /usr/bin/php && \
    # Install Composer \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --version=2.1.0 && \
    # Configure php.ini
    mkdir -p /etc/php && \
    echo $'memory_limit = 1024M' >> /etc/php/php.ini && \
    rm -rf /var/cache/apk/* && \
    composer global require deployer/deployer "^v7.0.0-rc.4" && \
    composer global require deployer/recipes && \
    # Cleanup image
    apk del make g++ libgcc gcc binutils curl libcurl autoconf perl

    # binutils

# Install Deployer
ENV PATH="/root/.composer/vendor/bin:${PATH}"
