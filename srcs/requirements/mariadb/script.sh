#!/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
	mysql_install_db
fi

exec mysqld
