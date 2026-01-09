# # Use the lightweight Alpine-based Node image
# FROM node:20-alpine

# # Set the working directory inside the container
# WORKDIR /app

# # Copy package files first to leverage Docker caching
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application code
# COPY . .

# # Expose the port React runs on (usually 3000 or 5173 for Vite)
# EXPOSE 5173

# # Start the development server
# CMD ["npm", "run", "dev", "--", "--host"]


# Use Node.js for building
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Use Nginx to serve the build
FROM nginx:alpine
# Check your local project: if 'npm run build' creates a 'dist' folder, use /app/dist
# If it creates a 'build' folder, use /app/build
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]