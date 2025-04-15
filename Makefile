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
	@mkdir -p $(HOME_PATH)/data/web
	@mkdir -p $(HOME_PATH)/data/db
	@docker compose -f srcs/docker-compose.yml up -d --build

clean:
	@docker compose -f srcs/docker-compose.yml down  --remove-orphans

re: clean all

logs:
	@echo "=== NGINX ==="
	@docker logs nginx
	@echo "\n=== WORDPRESS ==="
	@docker logs wp-php
	@echo "\n=== MARIADB ==="
	@docker logs mariadb

nginx:
	docker exec -it nginx bash

wp-php:
	docker exec -it wp-php bash

db:
	docker exec -it mariadb bash

.PHONY: all clean re logs
