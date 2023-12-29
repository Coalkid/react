# Stage 1: Build the React app
FROM node:alpine3.19 as build

WORKDIR /app

COPY package*.json ./
#COPY /public .
#COPY /src .

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Serve the React app with Nginx
FROM nginx:alpine

# Copy the build files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]