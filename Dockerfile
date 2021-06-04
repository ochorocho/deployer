FROM alpine:3.13

# Install PHP + mods
RUN apk --update --no-cache --update-cache --allow-untrusted add \
    rsync git curl php7 php7-json php7-mbstring php7-openssl php7-phar g++ make autoconf zip unzip php-zip && \
    # Install Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --version=2.1.0 && \
    # Configure php.ini
    echo $'memory_limit = 1024M' >> /etc/php7/php.ini && \
    rm -rf /var/cache/apk/* && \
    composer global require deployer/deployer "^6.8.0" && \
    composer global require deployer/recipes && \
    # Cleanup image
    apk del make g++ libgcc gcc binutils curl libcurl autoconf perl

    # binutils

# Install Deployer
ENV PATH="/root/.composer/vendor/bin:${PATH}"
