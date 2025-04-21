#!/bin/bash

GRN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

# don't need this but just for safety
if [ ! -d /run/mysqld ]; then
	mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
else
	echo -e "-> run/mysqld exists"
fi

while [ ! -d /var/lib/mysql ]; do
  echo "Waiting for volume to mount..."
  sleep 10
done

echo -e "checking /var/lib/mysql"
ls -la /var/lib/mysql
echo

INIT_MARKER=/var/lib/mysql/.init_done

if [ -d ${INIT_MARKER} ]
then
	echo -e "-> db is ready\n"
else
	echo "Initializing DB..."
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db \
		--datadir=/var/lib/mysql \
		--user=mysql > /dev/null
	
	INIT_SQL=/tmp/init.sql

	# solve --skip-grant-tables situation
	echo "USE mysql;" > ${INIT_SQL}
	echo "FLUSH PRIVILEGES;" >> ${INIT_SQL}

	# delete extra
	echo "DELETE FROM mysql.user WHERE User='';" >> ${INIT_SQL}
	echo "DROP DATABASE IF EXISTS test;" >> ${INIT_SQL}
	echo "DELETE FROM mysql.db WHERE Db='test';" >> ${INIT_SQL}

	# for safety
	echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" >> ${INIT_SQL}

	# root will need password
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';" >> ${INIT_SQL}

	# create user
	echo "CREATE DATABASE ${DB_NAME};" >> ${INIT_SQL}
	echo "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';" >> ${INIT_SQL}
	echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';" >> ${INIT_SQL}
	echo "FLUSH PRIVILEGES;" >> ${INIT_SQL}

	# mysql"d" for calling out the socket
	# --bootstrap for the init
	mysqld \
		--user=mysql \
		--bootstrap < ${INIT_SQL} \
	&& echo -e "${GRN}users were set\n${RESET}" && touch ${INIT_MARKER}\
	|| echo -e "${RED}failed create user and set root password${RESET}"
fi

echo "--- run container ---"
exec mariadbd  \
	--user=mysql \
	--datadir=/var/lib/mysql \
	--bind-address=0.0.0.0 \

# if [ ! -d /var/lib/mysql/mysql ]; then
# 	echo "Initializing DB..."
# 	chown -R mysql:mysql /var/lib/mysql
# 	mysql_install_db \
# 		--user=mysql \
# 		--datadir=/var/lib/mysql

# 	envsubst < /etc/mysql/init.sql.template  | sed 's/"/'\''/g' > /etc/mysql/init.sql

# 	echo "--- init.sql generated ---"
# 	cat /etc/mysql/init.sql
# 	echo 
# 	ls -l /etc/mysql/init.sql
# 	echo

# 	ls -la /run/mysqld
# 	echo
# 	mysqld --user=mysql --bootstrap < /etc/mysql/init.sql && \
# 	echo "init.sql executed successfully" || \
# 	echo "init.sql failed"
# 	echo
# else
# 	echo "db already initialzed."
# fi
