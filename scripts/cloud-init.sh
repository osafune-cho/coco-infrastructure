#!/bin/bash

set -eou pipefail

{
    echo "export DB_HOST=\"${DB_HOST}\""
    echo "export DB_USER=\"${DB_USER}\""
    echo "export DB_PASSWORD=\"${DB_PASSWORD}\""
    echo "export DB_NAME=\"${DB_NAME}\""
    echo "export DB_PORT=\"${DB_PORT}\""
    echo "export DB_SSLMODE=\"require\""
    echo "export AZURE_STORAGE_ACCOUNT_NAME=\"${AZURE_STORAGE_ACCOUNT_NAME}\""
    echo "export AZURE_STORAGE_ACCOUNT_KEY=\"${AZURE_STORAGE_ACCOUNT_KEY}\""
    echo "export AZURE_STORAGE_CONTAINER_NAME=\"${AZURE_STORAGE_CONTAINER_NAME}\""
} >> /etc/profile

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# shellcheck disable=SC1091
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker
