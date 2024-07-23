FROM node:22.5.1 AS base
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . .
RUN apt-get update &&\
    apt-get clean autoclean ;\
    apt-get autoremove --yes ;\
    rm -rf /var/lib/{apt,dpkg,cache,log}/



FROM node:22-alpine

WORKDIR /app

COPY --from=base /app /app

RUN adduser -s /bin/sh -D kishor &&\
    chown -R kishor:kishor /app &&\ 
    chmod -R 777 /app

EXPOSE 80

USER kishor

CMD [ "node", "app.js" ]