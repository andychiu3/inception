UNAME = $(shell uname)

ifeq ($(UNAME), Darwin)
	HOME_PATH = /Users/$(USER)
else
	HOME_PATH = /home/$(USER)
endif

export HOME_PATH

# @grep -q '^HOME_PATH=' src/.env && \
# sed -i '' 's|^HOME_PATH=.*|HOME_PATH=$(HOME_PATH)|' src/.env || \
# echo "HOME_PATH=$(HOME_PATH)" >> src/.env

all:
	@mkdir -p $(HOME_PATH)/data/wordpress-volume
	@mkdir -p $(HOME_PATH)/data/mariadb-volume
	@docker compose -f srcs/docker-compose.yml up -d --build

clean:
	@docker compose -f srcs/docker-compose.yml down  --remove-orphans

fclean:
	docker stop $$(docker ps -qa);
	docker rm $$(docker ps -qa);
	docker rmi -f $$(docker images -qa);
	docker volume rm $$(docker volume ls -q);
	docker network rm $$(docker network ls -q) 2>/dev/null

re: clean all

logs:
	@echo "=== NGINX ==="
	@docker logs nginx
	@echo "\n=== WORDPRESS ==="
	@docker logs wordpress
	@echo "\n=== MARIADB ==="
	@docker logs mariadb

nginx:
	docker exec -it nginx bash

wordpress:
	docker exec -it wordpress bash

db:
	docker exec -it mariadb bash

.PHONY: all clean fclean re logs
