FROM node:lts-alpine
WORKDIR /app
COPY turkey.package.json /app/package.json
RUN npm install
COPY app.js index.js /app/
CMD node app.js
