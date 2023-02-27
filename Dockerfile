FROM alpine:3.17

# Install PHP + mods
RUN apk add rsync git curl php81 php81-json php81-mbstring php81-openssl php81-phar php81-curl g++ make autoconf zip unzip php-zip && \
    # Install Composer \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --version=2.5.4 && \
    # Configure php.ini
    echo $'memory_limit = 1024M' >> /etc/php81/php.ini && \
    composer global require deployer/deployer "^v7.2" && \
    # Cleanup image
    apk del make g++ libgcc gcc binutils autoconf perl && \
    rm -rf /var/cache/apk/*

# Install Deployer
ENV PATH="/root/.composer/vendor/bin:${PATH}"
