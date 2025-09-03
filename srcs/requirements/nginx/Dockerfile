FROM debian:buster

RUN apt-get update \
	&& apt-get install -y openssl \
	&& apt-get install -y nginx

RUN openssl req -x509 -nodes -days 365 -subj "/C=ES/ST=Madrid/O=42Madrid, Inc./CN=rcastano.42.fr" -addext "subjectAltName=DNS:rcastano.42.fr" -newkey rsa:2048 -keyout /etc/ssl/private/rcastano.key -out /etc/ssl/certs/rcastano.crt

RUN rm -rf /etc/nginx/sites-enabled/*

COPY tools/default.conf /etc/nginx/conf.d/

ENTRYPOINT ["nginx", "-g", "daemon off;"]