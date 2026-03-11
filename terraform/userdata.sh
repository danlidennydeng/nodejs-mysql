#!/bin/bash

# Update system
sudo apt update -y

# Install required packages
sudo apt install -y git curl

# Install Node.js 20 (recommended)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Clone repository
git clone https://github.com/danlidennydeng/nodejs-mysql.git /home/ubuntu/nodejs-mysql
cd /home/ubuntu/nodejs-mysql

# Create .env file
echo "DB_HOST=" > .env
echo "DB_USER=" >> .env
echo "DB_PASS=" >> .env
echo "DB_NAME=" >> .env
echo "TABLE_NAME=" >> .env
echo "PORT=" >> .env

# Install dependencies
npm install
chown -R ubuntu:ubuntu /home/ubuntu/nodejs-mysql
# Start server
# npm run dev