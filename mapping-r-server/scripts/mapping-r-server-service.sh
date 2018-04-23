#!/bin/bash

cd /app/mapping-r-server/target/bin

exec /sbin/setuser www-data /app/mapping-r-server/target/bin/r_server >> /var/log/mapping-r-server/server.log 2>&1

