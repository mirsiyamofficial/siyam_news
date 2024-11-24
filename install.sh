#!/bin/bash

# Update and upgrade packages
apt update && apt upgrade -y
pkg update && pkg upgrade -y

# Install necessary packages
pkg install git curl jq -y

# Clone the repository
git clone https://github.com/mirsiyamofficial/siyam_news.git

# Change directory
cd siyam_news

# Make the script executable
chmod +x run.sh

# Run the script
echo -e "\nRun the tool using: ./run.sh"
