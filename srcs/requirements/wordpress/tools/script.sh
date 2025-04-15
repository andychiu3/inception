#!/bin/bash

# set -a
# source /var/www/html/.env
# set +a
# -> use env_file instead

cd /var/www/html

echo "-> checking WordPress Status"

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "-> Installing WordPress"
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	# mv wp-cli.phar /usr/local/bin/wp # keep it in the volume instead
	./wp-cli.phar core download --allow-root
	./wp-cli.phar config create \
		--dbname=${DB_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_PASSWORD} \
		--dbhost=${DB_HOST} \
		--allow-root
	./wp-cli.phar core install \
		--url=${WP_URL} \
		--title=${WP_TITLE} \
		--admin_user=${WP_ADMIN} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL} \
		--allow-root
	./wp-cli.phar user create \
		${WP_USER} ${WP_USER_EMAIL} \
		--user_pass=${WP_USER_PASSWORD} \
 		--role=author \
		--allow-root

else
	echo "-> WordPress already installed"
fi

# exec means change the PPID to php-fpm7.4 -F instead of .sh
exec php-fpm7.4 -F
