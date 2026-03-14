#!/bin/bash
set -e

curl -fsSL "https://downloads.slack-edge.com/desktop-releases/linux/x64/latest/slack-desktop-latest-amd64.deb" -o /tmp/slack.deb
sudo apt-get install -y /tmp/slack.deb
rm /tmp/slack.deb
