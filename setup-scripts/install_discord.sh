#!/bin/bash
set -e

curl -fsSL "https://discord.com/api/download?platform=linux&format=deb" -o /tmp/discord.deb
sudo apt-get install -y /tmp/discord.deb
rm /tmp/discord.deb
