#!/bin/bash

# Check if curl is installed and install it if necessary
if ! [ -x "$(command -v curl)" ]; then
  sudo apt-get update
  sudo apt-get install curl -y
fi

# Download Nginx signing key using curl
curl -fsSL https://nginx.org/keys/nginx_signing.key -o nginx_signing.key

# Import the key using gpg
gpg --import nginx_signing.key

# Verify the fingerprint of the key
gpg --fingerprint ABF5BD827BD9BF62

# Create a file named nginx.list in the /etc/apt/sources.list.d directory
echo "deb https://nginx.org/packages/mainline/ubuntu/ $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
echo "deb-src https://nginx.org/packages/mainline/ubuntu/ $(lsb_release -cs) nginx" | sudo tee -a /etc/apt/sources.list.d/nginx.list

# Update the package list on the server
sudo apt-get update

# Install Nginx
sudo apt-get install nginx -y

# Start the Nginx service
sudo systemctl start nginx

# Enable Nginx to start automatically when the server starts
sudo systemctl enable nginx
