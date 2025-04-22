FROM  debian:bullseye

RUN  apt-get update \
  && apt-get install -y \
  php \
  php-fpm \
  php-mysqli \
  curl \
  && rm -rf /var/lib/apt/lists/*

# docker cp /etc/php/7.4/fpm/pool.d/www.conf ./requirements/wordpress/.
# revise /requirements/wordpress/www.conf as we want changing the setting
# COPY back then
COPY  /conf/www.conf /etc/php/7.4/fpm/pool.d/

# WORKDIR /var/www/html

# RUN  wget https://wordpress.org/latest.tar.gz \
#   && tar -xzf latest.tar.gz -C /var/www/ \
#   && rm latest.tar.gz
# change to use script for wp-cli

# RUN  chown -R www-data:www-data /var/www/wordpress

# this is a must. When we run the php would need dir: /run/php
# default would be root:root which means we will have to change it
RUN mkdir -p /run/php \
&& chown www-data:www-data /run/php

COPY  tools/script.sh .
RUN  chmod +x script.sh
# EXPOSE  9000

CMD  ["./script.sh"]
# CMD  ["php-fpm7.4", "-F"]
