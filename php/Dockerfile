FROM php:5.6-cli

# FYI: PHP is located under /usr/local/etc/php !

RUN apt-get update && apt-get install -y git libvirtodbc0 php5-xdebug unzip unixODBC-dev xsltproc zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql zip

# setup php5-xdebug
RUN php5enmod xdebug
RUN cp /etc/php5/mods-available/xdebug.ini /usr/local/etc/php/conf.d
RUN cp /usr/lib/php5/20131226/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so

# install ODBC (https://github.com/docker-library/php/issues/103)
RUN docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
    && docker-php-ext-install pdo_odbc

# enable extensions
RUN docker-php-ext-enable mysqli pdo pdo_mysql pdo_odbc

# setup ODBC for Virtuoso
RUN set -ex \
 && { \
  echo '[ODBC Data Sources]'; \
  echo 'VOS = Virtuoso'; \
  echo; \
  echo '[VOS]'; \
  echo 'Driver = /usr/lib/x86_64-linux-gnu/odbc/virtodbc.so'; \
  echo 'Address = virtuoso:1111'; \
 } | tee /etc/odbc.ini

# install composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /app
WORKDIR /app

COPY php.ini /usr/local/etc/php/php.ini

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD [ "/start.sh" ]
