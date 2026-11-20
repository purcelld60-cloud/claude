# Imagem do servidor online. Construa a partir da RAIZ do repositório:
#   docker build -f server/Dockerfile -t daroca .
FROM python:3.12-alpine AS trilhas
WORKDIR /app
COPY dist/music ./dist/music
COPY .github/scripts/restaurar_trilhas.py ./.github/scripts/
RUN python3 .github/scripts/restaurar_trilhas.py
COPY dist ./dist

FROM node:22-alpine
WORKDIR /app
COPY server/package.json server/package-lock.json ./server/
RUN cd server && npm ci --omit=dev
COPY server/server.js ./server/
COPY --from=trilhas /app/dist ./dist
ENV PORT=8080 NODE_ENV=production
EXPOSE 8080
USER node
CMD ["node", "server/server.js"]
