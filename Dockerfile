# First Build
FROM node:lts-alpine3.10
#WORKDIR /src
WORKDIR /.
RUN apk update --no-cache && apk add --no-cache g++ make py2-packaging && rm -rf /var/cache/apk/* /tmp/* && chown -R node:node /src
USER node
RUN npm install && npm rebuild && rm -f .npmrc
COPY package*.json ./
ADD . /src

#RUN npm install
#RUN npm audit fix
#COPY . .

#EXPOSE 3000
#CMD [ "npm", "start" ]  
