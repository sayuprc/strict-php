FROM php:8.4-cli

WORKDIR /var/www

RUN apt update -y \
  && apt install -y unzip git vim \
  && pecl channel-update pecl.php.net \
  && pecl install xdebug \
  && docker-php-ext-enable xdebug

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

ARG UID=1000
ARG GID=1000
ARG USERNAME=user
ARG GROUPNAME=user

RUN groupadd -g $GID $GROUPNAME \
    && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

USER $USERNAME
