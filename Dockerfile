# First Build
FROM node:lts-alpine3.10
WORKDIR /src
RUN apk update --no-cache && apk add --no-cache g++ make py2-packaging && rm -rf /var/cache/apk/* /tmp/* && chown -R node:node /src
USER node
RUN npm install && npm rebuild && rm -f .npmrc
