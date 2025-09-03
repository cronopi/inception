#image OS
FROM debian:buster

#store env variables
ARG DB_NAME MYSQL_ADMIN_USER MYSQL_PASSWORD MYSQL_ROOT_PASSWORD

#install mariadb
RUN apt update -y && apt install -y mariadb-server

#copy our modified config file in the mariadb container
COPY /conf/50-server.cnf etc/mysql/mariadb.conf.d/

#initialize the database
RUN echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" >> configure.sql
RUN echo "CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> configure.sql
RUN echo "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> configure.sql
RUN echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> configure.sql

RUN service mysql start && mysql < configure.sql

CMD ["mysqld"]
