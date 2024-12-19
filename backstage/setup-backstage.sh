#!/bin/bash

set -e

# Update system
echo "Updating system..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Install dependencies
echo "Installing required tools and dependencies..."
sudo apt-get install -y curl gnupg2 lsb-release apt-transport-https ca-certificates software-properties-common

# Install Node.js LTS (v18.x)
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Yarn
echo "Installing Yarn..."
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install -y yarn

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Add Vagrant user to Docker group
echo "Configuring Docker permissions..."
sudo usermod -aG docker vagrant

# Install Git
echo "Installing Git..."
sudo apt-get install -y git

# Install PostgreSQL
echo "Installing PostgreSQL..."
sudo apt-get install -y postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Create PostgreSQL user and database
echo "Configuring PostgreSQL database..."
sudo -u postgres psql -c "CREATE USER backstage WITH PASSWORD 'backstage';"
sudo -u postgres psql -c "CREATE DATABASE backstage OWNER backstage;"

# Installing the XFCE desktop (GUI)
sudo apt-get install -y --no-install-recommends lubuntu-desktop

# Set up Backstage
echo "Setting up Spotify Backstage..."
sudo -u vagrant bash <<EOF
  mkdir -p ~/backstage && cd ~/backstage
  echo "my-backstage-app" | npx @backstage/create-app
  cd my-backstage-app
  yarn install
EOF

echo "Backstage setup complete! To start the app, run:"
echo "cd ~/backstage/my-backstage-app && yarn dev"
