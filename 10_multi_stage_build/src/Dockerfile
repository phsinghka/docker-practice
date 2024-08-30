FROM node:14 AS build

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

#STEP 2 RUN STAGE

FROM node:alpine

WORKDIR /app 

COPY --from=build /app /app

EXPOSE 8080

CMD ["npm","start"]

