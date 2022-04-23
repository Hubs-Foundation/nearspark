FROM node:lts-alpine
WORKDIR /app
COPY package.json /app
COPY app.js /app
RUN npm install
CMD node app.js
