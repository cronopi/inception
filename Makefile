DATA_DIR = /home/rcastano/data/mysql
DATA_DIR2 = /home/rcastano/data/webserver
COMPOSE_FILE = ./srcs/compose.yml

all:
	mkdir -p ${DATA_DIR}
	@NO_COLOR=1 docker-compose -f ${COMPOSE_FILE} up -d --build

down:
	@docker-compose -f ${COMPOSE_FILE} down

logs:
	@docker-compose -f ${COMPOSE_FILE} logs -f

ps:
	@docker-compose -f ${COMPOSE_FILE} ps

clean:
	@sudo chown -R rcastano:rcastano ${DATA_DIR}
	@sudo chown -R rcastano:rcastano ${DATA_DIR2}
	@sudo rm -rf ${DATA_DIR}/*
	@sudo rm -rf ${DATA_DIR2}/*

	@echo "Deteniendo contenedor mariadb..."
	@if [ -n "$$(docker ps -q -f name=mariadb)" ]; then docker stop $$(docker ps -q -f name=mariadb); fi
	@if [ -n "$$(docker ps -q -f name=nginx)" ]; then docker stop $$(docker ps -q -f name=nginx); fi
	@if [ -n "$$(docker ps -q -f name=wordpress)" ]; then docker stop $$(docker ps -q -f name=wordpress); fi


	@echo "Eliminando contenedor mariadb..."
	@if [ -n "$$(docker ps -a -q -f name=mariadb)" ]; then docker rm $$(docker ps -a -q -f name=mariadb); fi
	@if [ -n "$$(docker ps -a -q -f name=nginx)" ]; then docker rm $$(docker ps -a -q -f name=nginx); fi
	@if [ -n "$$(docker ps -a -q -f name=wordpress)" ]; then docker rm $$(docker ps -a -q -f name=wordpress); fi

	@echo "Eliminando imagen mariadb..."
	@if [ -n "$$(docker images -q mariadb:latest)" ]; then docker rmi -f mariadb:latest; fi
	@if [ -n "$$(docker images -q nginx:latest)" ]; then docker rmi -f nginx:latest; fi
	@if [ -n "$$(docker images -q wordpress:latest)" ]; then docker rmi -f wordpress:latest; fi

	@echo "Eliminando volumen mariadb..."
	@if [ -n "$$(docker volume ls -q | grep mariadb_data)" ]; then docker volume rm -f mariadb_data; fi
	@if [ -n "$$(docker volume ls -q | grep nginx_data)" ]; then docker volume rm -f nginx_data; fi
	@if [ -n "$$(docker volume ls -q | grep wordpress_data)" ]; then docker volume rm -f wordpress_data; fi

	@echo "Eliminando red srcs_default..."
	@if docker network ls | grep -q srcs_default; then docker network rm srcs_default; fi

	@echo "Eliminando volúmenes no utilizados..."
	@docker volume prune -f

	@echo "Limpieza completada con éxito."

fclean: down clean

.PHONY: all down clean fclean logs ps
