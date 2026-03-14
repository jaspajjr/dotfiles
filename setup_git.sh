#!/bin/bash
set -e

# Install git
sudo apt-get update
sudo apt-get install -y git

# Configure git
read -rp "Git user name: " git_name
read -rp "Git email: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

echo "Git installed and configured for $git_name <$git_email>"

# Generate SSH key
ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/id_ed25519

echo ""
echo "SSH public key (add this to GitHub):"
cat ~/.ssh/id_ed25519.pub
