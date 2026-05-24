FROM node:20.14-bullseye-slim AS base

ENV NODE_ENV=production
WORKDIR /usr/src/app

COPY package*.json ./

RUN --mount=type=cache,target=/usr/src/app/.npm \
  npm set cache /usr/src/app/.npm && \
  npm ci --only=production

USER node

COPY --chown=node:node healthcheck/healthcheck.js ./
COPY --chown=node:node ./src/ .

EXPOSE 3001

CMD [ "node", "index.js" ]
