FROM node:20-alpine as base
WORKDIR /app
ENV NUXT_PORT=3000
ENV HOST=0.0.0.0
EXPOSE 3000

FROM base as deps
COPY package*.json ./
RUN NODE_PATH=/node_modules npm install


FROM deps as builder
COPY . .
RUN NODE_PATH=/node_modules npm run build


FROM base as production
COPY package*.json ./
RUN NODE_PATH=/node_modules npm install --omit=dev
COPY --from=builder /app/.output ./.output
CMD ["node", ".output/server/index.mjs"]

# final stage for development
FROM deps as development
COPY . .
ENV NODE_PATH=/node_modules
CMD ["npm", "run", "dev"]
