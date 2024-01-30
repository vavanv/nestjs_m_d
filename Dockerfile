FROM node:20.10.0 AS development

WORKDIR /usr/src/app

COPY package*.json ./

RUN yarn -g rimraf

RUN yarn --dev

COPY . .

RUN yarn build

FROM node:20.10.0 as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json ./

RUN yarm --prod

COPY . .

COPY --from=development /usr/src/app/dist ./dist

CMD ["node", "dist/main"]
