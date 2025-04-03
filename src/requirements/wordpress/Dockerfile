FROM  bebian:bulleye

RUN  apt-get update \
  && apt-get install -y php-fpm php-mysql wget \
  && rm -rf /var/lib/apt/lists/*

RUN  wget https://wordpress.org/latest.tar.gz \
  && tar -xzf latest.targz -C /var/www/ \
  && rm latest.tar.gz

RUN  chown -R www-data:www-data /var/www/wordpress

EXPOSE  9000

CMD  ["php-fpm7.4", "-F"]
