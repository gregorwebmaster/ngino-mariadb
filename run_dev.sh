#!/usr/bin/env bash

docker build -t maria-db .
docker run --name maria-db -d -e ROOT_PSWD='topsecret' -e DATABASE_ADMIN='superadmin' -e ADMIN_PSWD='Pizza!23' maria-db
docker ps -a -f name='maria-db'

echo "configuration ...."

sleep 12
docker logs maria-db