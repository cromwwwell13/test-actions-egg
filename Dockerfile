# Etapa 1: Construcción con Node
FROM node:20 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --configuration=production

# Etapa 2: Servidor Nginx para los archivos estáticos
FROM nginx:alpine
# Ajusta "nombre-de-tu-app" al nombre que sale en la carpeta /dist
COPY --from=build /app/dist/app-test/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
