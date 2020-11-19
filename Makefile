include ./config/.env
export $(shell sed 's/=.*//' ./config/.env)

THIS_FILE := $(lastword $(MAKEFILE_LIST))

CELERY_YAML=docker-compose-CeleryExecutor.yml
DC=docker-compose

.PHONY: help build up start down destroy stop restart logs logs-api ps login-timescale db-shell

up:
	$(DC) -f $(CELERY_YAML) up -d $(c)
down:
	$(DC) -f $(CELERY_YAML) down $(c)
build:
	$(DC) -f $(CELERY_YAML) build $(c)
start:
	$(DC) -f $(CELERY_YAML) start $(c)
destroy:
	$(DC) -f $(CELERY_YAML) down -v $(c)
stop:
	$(DC) -f $(CELERY_YAML) stop $(c)
restart:
	$(DC) -f $(CELERY_YAML) stop $(c)
	$(DC) -f $(CELERY_YAML) up -d $(c)
logs:
	$(DC) -f $(CELERY_YAML) logs --tail=100 -f $(c)
logs-api:
	$(DC) -f $(CELERY_YAML) logs --tail=100 -f api
ps:
	$(DC) -f $(CELERY_YAML) ps
top:
	$(DC) -f $(CELERY_YAML) top
login-postgres:
	$(DC) -f $(CELERY_YAML) exec postgres /bin/bash
db-shell:
	$(DC) -f $(CELERY_YAML) exec postgres psql -Upostgres