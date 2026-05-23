#!/bin/bash
set -e

TERRAFORM_VERSION=$(curl -fsSL https://checkpoint-api.hashicorp.com/v1/check/terraform | python3 -c "import sys,json; print(json.load(sys.stdin)['current_version'])")
ARCH=$(dpkg --print-architecture)

curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip" -o /tmp/terraform.zip
sudo unzip -o /tmp/terraform.zip -d /usr/local/bin terraform
sudo chmod +x /usr/local/bin/terraform
rm /tmp/terraform.zip

terraform version
