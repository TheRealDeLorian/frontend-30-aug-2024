FROM node:20 AS dist

WORKDIR /app
COPY package*.json ./
RUN npm install 
COPY . . 
RUN npm run dist
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=dist /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]