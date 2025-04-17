# syntax=docker/dockerfile:1.4

# Базовый слой
FROM node:23-slim AS base
WORKDIR /app
ENV NUXT_PORT=3000
ENV HOST=0.0.0.0
EXPOSE 3000

# Слой для установки зависимостей и сборки
FROM base AS builder

# Установка инструментов для node-gyp и нативных модулей
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

# Установка зависимостей с кэшем
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm install

# Копируем весь исходный код
COPY . .

# Сборка Nuxt-проекта
RUN npm run build

# Финальный слой продакшн-окружения
FROM base AS production

# Установка системных зависимостей (для runtime поддержки нативных модулей, если нужно)
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копируем package.json (чтобы повторно установить только прод-зависимости)
COPY package*.json ./

# Установка только продакшн-зависимостей
RUN --mount=type=cache,target=/root/.npm \
    npm install --omit=dev

# Копируем только сборку (не node_modules!)
COPY --from=builder /app/.output ./.output

# Запуск сервера Nuxt
CMD ["node", ".output/server/index.mjs"]

# Отдельный слой для разработки
FROM builder AS development
CMD ["npm", "run", "dev"]
