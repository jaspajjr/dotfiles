#!/bin/bash
set -e

COMPOSE_VERSION=$(curl -fsSL "https://api.github.com/repos/docker/compose/releases/latest" | grep '"tag_name"' | cut -d'"' -f4)
ARCH=$(uname -m)

sudo curl -fsSL "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-linux-${ARCH}" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker-compose version
