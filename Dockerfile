FROM node:lts-buster

RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  npm i pm2 -g && \
  rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/cyber-dexter-lite/dexter-id-backup.git /root/zokou_Bot
WORKDIR /root/zokou_Bot/

COPY package.json .
RUN npm install pm2 -g
RUN npm install --legacy-peer-deps

COPY . .

# Expose port
EXPOSE 5000

# Use PM2 to keep the application alive
CMD ["pm2", "start", "index.js", "--name", "zokou_bot", "--watch"]
