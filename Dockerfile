FROM node:10 AS ui-build
WORKDIR /usr/src/app
COPY deploy/ ./deploy/
RUN cd deploy && npm install && npm run build

FROM node:10 AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/deploy/build ./deploy/build
COPY deploy/package*.json ./deploy/
RUN cd api && npm install


EXPOSE 3080

CMD ["node", "./server.js"]
