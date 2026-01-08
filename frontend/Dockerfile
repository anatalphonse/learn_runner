# Use the lightweight Alpine-based Node image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package files first to leverage Docker caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port React runs on (usually 3000 or 5173 for Vite)
EXPOSE 5173

# Start the development server
CMD ["npm", "run", "dev", "--", "--host"]