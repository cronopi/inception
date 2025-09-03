#image OS
FROM debian:buster

#install wordpress dependencies
RUN mkdir -p /run/php
RUN apt update -y && apt install -y php7.3 php7.3-mysqli php7.3-fpm wget mariadb-client

COPY /conf/www.conf /etc/php/7.3/fpm/pool.d

#download wp-cli and give permissions
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

#copy and execute script to configure wordpress installation
COPY /conf/configure.sh .
RUN chmod 777 configure.sh
CMD ["./configure.sh"]