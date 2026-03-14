#!/bin/bash
set -e

curl -fsSL "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -o /tmp/chrome.deb
sudo apt-get install -y /tmp/chrome.deb
rm /tmp/chrome.deb
