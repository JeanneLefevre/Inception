NAME := Inception

COMPOSE_FILE := srcs/docker-compose.yml
SRC_DIR := srcs
SECRETS_DIR := secrets

DC := docker-compose -f $(COMPOSE_FILE)

MARIADB_DATA_DIR := /home/jealefev/data/mariadb
WORDPRESS_DATA_DIR := /home/jealefev/data/wordpress


all: mkdir_dirs up

mkdir_dirs:
	@echo "Création des répertoires nécessaires..."
	@mkdir -p /home/jealefev/data
	@mkdir -p $(MARIADB_DATA_DIR) $(WORDPRESS_DATA_DIR)

up:
	@echo "Lancement des containers..."
	$(DC) up -d --build
	
down:
	@echo "Arrêt et suppression des containers..."
	$(DC) down
	
rebuild: down up
	@echo "Reconstruction des containers..."
	
logs:
	@echo "Affichage des logs..."
	$(DC) logs -f

pull:
	@echo "Mise à jour des images..."
	$(DC) pull

exec:
	@echo "Exécution d'un bash dans le service nginx..."
	$(DC) exec -T nginx bash

migrate:
	@echo "Lancement des migrations WordPress..."
	$(DC) exec -T wordpress wp core update-db

build:
	@echo "Construction des services..."
	$(DC) build

prune:
	@echo "Nettoyage des images et containers inutilisés..."
	docker system prune -f

ps:
	@echo "Affichage des containers en cours d'exécution..."
	$(DC) ps

config:
	@echo "Vérification des configurations Docker Compose..."
	$(DC) config

dv:
	@echo "Arrêt et suppression des containers et volumes..."
	$(DC) down -v --remove-orphans

re: down dv prune up

clean: down dv prune