FROM node:20-alpine
WORKDIR /app

# COPY /public /app/public
# COPY /src /app/src
# COPY index.html /appindex.html
# COPY package-lock.json /app/package-lock.json
# COPY package.json /app/package.json
# COPY tsconfig.app.json /app/tsconfig.app.json
# COPY tsconfig.json /app/tsconfig.json
# COPY tsconfig.node.json /app/tsconfig.node.json
# COPY vite.config.ts /app/vite.config.ts
COPY package*.json ./
COPY tsconfig*.json ./
COPY vite.config.ts ./
COPY . .

RUN npm install

EXPOSE 80

CMD [ "npm","run","dev","--","--host","0.0.0.0","--port", "80" ]