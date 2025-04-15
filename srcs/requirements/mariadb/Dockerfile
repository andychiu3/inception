FROM  debian:bullseye

RUN  apt-get update \
  && apt-get install -y \
  mariadb-server

COPY  /conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY  /conf/init.sql /etc/mysql/init.sql
COPY  /tools/script.sh .

RUN  mkdir /run/mysqld && chmod +x script.sh

CMD ["./script.sh"]
