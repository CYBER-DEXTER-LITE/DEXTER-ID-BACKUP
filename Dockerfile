# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy bot source code
COPY . .

# Expose port for Keep Alive Server
EXPOSE 3000

# Start Keep Alive Server and Bot
CMD ["sh", "-c", "node keep_alive.js & node index.js"]
