UNAME = $(shell uname)

ifeq ($(UNAME), Darwin)
	HOME_PATH = /Users/$(USER)
else
	HOME_PATH = /home/$(USER)
endif

export HOME_PATH

VOLUME_NAME=mariadb-volume
HOST_PATH=$(HOME_PATH)/data/mariadb-volume

# init:
# 	@mkdir -p $(HOME_PATH)/data/wordpress-volume
# 	@mkdir -p $(HOME_PATH)/data/mariadb-volume
# 	docker volume create \
# 		--driver local \
# 		--opt type=none \
# 		--opt o=bind \
# 		--opt device=$(HOST_PATH) \
# 		$(VOLUME_NAME)

all:
	@mkdir -p $(HOME_PATH)/data/wordpress-volume
	@mkdir -p $(HOME_PATH)/data/mariadb-volume
	@chmod -R 777 ${HOME_PATH}/data/mariadb-volume
	@chmod -R 777 ${HOME_PATH}/data/wordpress-volume
	@docker compose -f srcs/docker-compose.yml up -d --build

clean:
	@docker compose -f srcs/docker-compose.yml down  --remove-orphans

fclean:
	-docker stop $$(docker ps -qa);
	-docker rm $$(docker ps -qa);
	-docker rmi -f $$(docker images -qa);
	-docker volume rm $$(docker volume ls -q);
	-docker network rm $$(docker network ls -q) 2>/dev/null
	# -rm -rf $(HOME_PATH)/data

re: clean all

logs:
	@echo "=== NGINX ==="
	@docker logs nginx
	@echo "\n=== WORDPRESS ==="
	@docker logs wordpress
	@echo "\n=== MARIADB ==="
	@docker logs mariadb

ls:
	docker ps; echo
	docker image ls; echo
	docker volume ls; echo
	docker network ls; echo

nginx:
	docker exec -it nginx bash

wp:
	docker exec -it wordpress bash

db:
	docker exec -it mariadb bash

.PHONY: all clean fclean re logs
