FROM  debian:bullseye

RUN  apt-get update \
  && apt-get install -y \
  mariadb-server

COPY  50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY  init.sql /etc/mysql/init.sql
COPY  script.sh .

RUN  mkdir /run/mysqld && chmod +x script.sh

CMD ["./script.sh"]
