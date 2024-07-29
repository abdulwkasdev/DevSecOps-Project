FROM node:16.17.0-alpine as build
ARG VITE_APP_TMDB_V3_API_KEY
WORKDIR /app
COPY package*.json ./
RUN npm install 
COPY . /app 
ENV VITE_APP_API_ENDPOINT_URL=https://api.themoviedb.org/3
ENV VITE_APP_TMDB_V3_API_KEY=$VITE_APP_TMDB_V3_API_KEY
RUN npm run build

# Nginx Stage
FROM nginx:stable-alpine-perl
COPY --from=build /app/dist/ /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]