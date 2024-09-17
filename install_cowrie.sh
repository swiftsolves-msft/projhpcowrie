#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install necessary packages
sudo apt install -y python3-pip python3-venv python3-dev libssl-dev libffi-dev build-essential git

# Set up iptables for port redirection
sudo iptables -t nat -A PREROUTING -p tcp --dport 22 -j REDIRECT --to-port 2222
sudo iptables -t nat -A PREROUTING -p tcp --dport 23 -j REDIRECT --to-port 2223

# Create a new user for Cowrie
sudo useradd -m -s /bin/bash -c "Cowrie" cowrie

# Switch to the cowrie user and perform actions
sudo -i -u cowrie bash <<EOF
# Clone Cowrie repository
git clone https://github.com/cowrie/cowrie.git

# Navigate to the Cowrie directory
cd cowrie

# Set up a Python virtual environment
python3 -m venv cowrie-env
source cowrie-env/bin/activate

# Install required Python packages
pip install -r requirements.txt

# Start Cowrie
bin/cowrie start
EOF