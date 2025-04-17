include .env
export
# Имя базового образа
IMAGE_BASE := nuxt3-app
# Значение по умолчанию, если в .env переменная PORT не задана
PORT ?= 3000
# Извлечение версии из package.json
VERSION := $(shell jq -r .version package.json)
# Итоговый тег образа
IMAGE_TAG := $(IMAGE_BASE):v$(VERSION)
# Имена контейнеров
DEV_CONTAINER_NAME := nuxt3-dev
PROD_CONTAINER_NAME := nuxt3-prod

.PHONY: default dev prod build

default:
	@echo "📦 Версия проекта: v$(VERSION)"
	@echo ""
	@echo "📋 Доступные команды:"
	@echo "  make dev     🔧 Запуск в режиме разработки (hot-reload)"
	@echo "  make prod    🚀 Сборка и запуск в продакшене"
	@echo "  make build   🛠 Только сборка продакшн-образа"
	@echo "  make         📦 Показать эту справку"

dev:
	@echo "🧹 Удаляем старый dev-контейнер (если был)..."
	@docker rm -f $(DEV_CONTAINER_NAME) || true
	@echo "🐳 Сборка контейнера $(IMAGE_TAG) для разработки..."
	@docker build -t $(IMAGE_TAG) --target development .
	@echo "🚀 Запуск контейнера для разработки..."
	@docker run -d \
		--name $(DEV_CONTAINER_NAME) \
		-p $(PORT):3000 \
		-v $(CURDIR):/app \
		-v /app/node_modules \
		$(IMAGE_TAG)

prod:
	@echo "🧹 Удаляем старый prod-контейнер (если был)..."
	@docker rm -f $(PROD_CONTAINER_NAME) || true
	@echo "🐳 Сборка контейнера $(IMAGE_TAG) для продакшена..."
	@docker build -t $(IMAGE_TAG) --target production .
	@echo "🚀 Запуск контейнера для продакшена..."
	@docker run -d \
		--name $(PROD_CONTAINER_NAME) \
		-p $(PORT):3000 \
		$(IMAGE_TAG)

build:
	@echo "🐳 Сборка контейнера $(IMAGE_TAG) (production)..."
	@docker build -t $(IMAGE_TAG) --target production .
