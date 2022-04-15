FROM php:8.1.4-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev \
    mariadb-client libmagickwand-dev --no-install-recommends \
    libonig-dev \
    cron \
    nano \
    supervisor \
    libzip-dev \
    zlib1g-dev \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install sockets \
    && docker-php-ext-install zip

RUN pecl install apcu
RUN docker-php-ext-enable apcu

RUN pecl install uploadprogress \
    && echo 'extension=uploadprogress.so' > /usr/local/etc/php/conf.d/uploadprogress.ini

RUN apt update \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include \
    && docker-php-ext-install -j$(nproc) intl pdo_mysql bcmath mbstring exif gd

RUN pecl install imagick && docker-php-ext-enable imagick

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --version=2.3.5 --install-dir=/usr/local/bin --filename=composer

# Redis
RUN pecl install redis && docker-php-ext-enable redis

# XDebug
RUN pecl install xdebug-3.1.4
RUN docker-php-ext-enable xdebug
COPY ./xdebug.ini ../../../usr/local/etc/php/conf.d/xdebug.ini

ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="10000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="192" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

RUN docker-php-ext-install opcache

COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini
