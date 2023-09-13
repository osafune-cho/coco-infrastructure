#!/bin/bash

set -eou pipefail

{
    echo "export DB_HOST=${DB_HOST}"
    echo "export DB_USER=${DB_USER}"
    echo "export DB_PASSWORD=${DB_PASSWORD}"
    echo "export DB_NAME=${DB_NAME}"
    echo "export DB_PORT=${DB_PORT}"
    echo "export AZURE_STORAGE_ACCOUNT_NAME=${AZURE_STORAGE_ACCOUNT_NAME}"
    echo "export AZURE_STORAGE_ACCOUNT_KEY=${AZURE_STORAGE_ACCOUNT_KEY}"
    echo "export AZURE_STORAGE_CONTAINER_NAME=${AZURE_STORAGE_CONTAINER_NAME}"
} >> /etc/profile

sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
