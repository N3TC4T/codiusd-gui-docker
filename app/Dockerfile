FROM node:alpine

# set env variables
ENV NPM_CONFIG_LOGLEVEL warn
ENV NODE_ENV=production

# install git and
RUN apk add --no-cache git

# Create app directory
WORKDIR /usr/src/app


# clone the app
RUN git clone https://github.com/codius/codiusd-gui.git .


# Install app dependencies
RUN yarn install --production

# Install pm2 so we can run our application

EXPOSE 3300

CMD node index.js

