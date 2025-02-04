FROM node:lts-buster

# Install dependencies: ffmpeg, imagemagick, webp
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  npm i pm2 -g && \
  rm -rf /var/lib/apt/lists/*

# Clone the GitHub repository
RUN git clone https://github.com/cyber-dexter-lite/dexter-id-backup.git /root/zokou_Bot
WORKDIR /root/zokou_Bot/

# Copy package.json and install dependencies
COPY package.json .
RUN npm install --legacy-peer-deps

# Install PM2 globally
RUN npm install pm2 -g

# Copy the source files
COPY . .

# Copy the keep_alive.js file to the container
COPY keep_alive.js .

# Expose port for the app
EXPOSE 5000

# Start both the Keep Alive Server and the Bot
CMD ["sh", "-c", "pm2 start keep_alive.js && pm2 start index.js --name zokou_bot --watch"]
