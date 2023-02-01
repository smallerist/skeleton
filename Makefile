DOCKER := docker
DOCKER-COMPOSE := docker-compose

help: about args

about:
	@echo "Makefile to help manage docker-compose services"
	@echo "The Timezone for all docker container is Asia/Jakarta"

args:
	@echo
	@echo "Target arguments:"
	@echo " bash \t\tTo terminal integrated"
	@echo " config \tTo check content manifest compose file"
	@echo " up \t\tStarts containers (in detached mode). [all]"
	@echo " down \t\tRemoves containers (preserves images and volumes). [all]"
	@echo " services \tLists services."
	@echo " ps \t\tTo check content manifest compose file."
	@echo " logs \t\tShows output of running containers (in 'follow' mode). [all], [svc=<service_specific>]"
	@echo " start \t\tStarts previously-built containers. [all], [svc=<service_specific>]"
	@echo " stop \t\tStops containers (without removing them). [all], [svc=<service_specific>]"
	@echo " restart \tReload containers. [all], [svc=<service_specific>]"
	@echo " clean \t\tRemoves containers, images and volumes. [all]"

config:
	@$(DOCKER-COMPOSE) config

run: up bash

up:
	@$(DOCKER-COMPOSE) up -d

down:
	@$(DOCKER-COMPOSE) down

services:
	@$(DOCKER-COMPOSE) ps --services

ps:
	@$(DOCKER-COMPOSE) ps

logs:
ifeq ($(svc),all)
	@$(DOCKER-COMPOSE) logs --follow
else
	@$(DOCKER-COMPOSE) logs $(svc) --follow
endif

start:
ifeq ($(svc),all)
	@$(DOCKER-COMPOSE) start
else
	@$(DOCKER-COMPOSE) start $(svc)
endif

stop:
ifeq ($(svc),all)
	@$(DOCKER-COMPOSE) stop
else
	@$(DOCKER-COMPOSE) stop $(svc)
endif

restart:
ifeq ($(svc),all)
	@$(DOCKER-COMPOSE) restart
else
	@$(DOCKER-COMPOSE) restart $(svc)
endif

clean:
	@$(DOCKER-COMPOSE) down --volumes --rmi all

bash:
	docker exec -it $(shell docker-compose ps -q local-app)  bash