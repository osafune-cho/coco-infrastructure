#!/usr/bin/env bash

set -euo pipefail

ssh_private_key=$1
ssh_host_name=$2
ssh_user_name=$3
ssh_dist_path=$4

touch ./ssh_private_key
echo "$ssh_private_key" | tr -d '\r' > ./ssh_private_key
chmod 700 ./ssh_private_key
eval "$(ssh-agent)"
ssh-add ./ssh_private_key
mkdir -p ~/.ssh/
ssh-keyscan -H "$ssh_host_name" >> ~/.ssh/known_hosts

pwd
ls -la
scp -r -i ./ssh_private_key ./docker/docker-compose.yml "$ssh_user_name"@"$ssh_host_name":"$ssh_dist_path"
scp -r -i ./ssh_private_key ./caddy/Caddyfile "$ssh_user_name"@"$ssh_host_name":"$ssh_dist_path"/caddy

ssh -i ./ssh_private_key "$ssh_user_name"@"$ssh_host_name" <<"EOC"
  cd "$ssh_dist_path"
  docker-compose down
  docker-compose up -d
EOC
