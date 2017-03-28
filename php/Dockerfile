FROM php:5.6-cli

RUN apt-get update && apt-get install -y libvirtodbc0 unixODBC-dev && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql

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

RUN mkdir /app
WORKDIR /app

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD [ "/start.sh" ]
