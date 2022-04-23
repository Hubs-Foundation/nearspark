FROM node:lts-alpine
WORKDIR /app
COPY package.turkey.json /app/package.json
RUN npm install
COPY app.js index.js /app/
CMD node app.js
