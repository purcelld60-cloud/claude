# Imagem do servidor online. Construa a partir da RAIZ do repositório:
#   docker build -f server/Dockerfile -t daroca .
FROM node:22-alpine
WORKDIR /app
COPY server/package.json server/package-lock.json ./server/
RUN cd server && npm ci --omit=dev
COPY server/server.js ./server/
COPY dist ./dist
ENV PORT=8080 NODE_ENV=production
EXPOSE 8080
USER node
CMD ["node", "server/server.js"]
