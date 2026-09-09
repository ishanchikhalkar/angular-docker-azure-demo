# Stage 1: Build Angular application
FROM node:20 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy Angular project
COPY . .

# Build Angular application
RUN npm run build


# Stage 2: Run Angular using Nginx
FROM nginx:alpine

# Copy Angular build files to Nginx
COPY --from=build /app/dist/angular-docker-azure-demo /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]