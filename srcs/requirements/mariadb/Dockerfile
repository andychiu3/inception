FROM  debian:bullseye

RUN  apt-get update \
  && apt-get install -y \
  mariadb-server \
  gettext

# COPY  /conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
# COPY  /conf/init.sql.template /etc/mysql/init.sql.template
COPY  /tools/script.sh .
RUN  chmod +x script.sh

# RUN mysql_install_db \
# 	--user=mysql \
# 	--datadir=/var/lib/mysql \
# 	&& chown -R mysql:mysql /var/lib/mysql

RUN  mkdir /run/mysqld \
  && chown -R mysql:mysql /run/mysqld
#   && mkdir -p /etc/mysql \
#   && chmod +x script.sh

CMD ["./script.sh"]
