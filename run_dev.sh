#!/usr/bin/env bash

docker build -t maria-db .
docker run --name maria-db -d -e DATABASE_ADMIN='superadmin' -e ADMIN_PSWD='Pizza!23' maria-db
docker ps -a -f name='maria-db'

echo "configuration ...."

sleep 15
docker logs maria-db