#! /bin/bash

openssl dhparam -out /storage/dhparam.pem 2048
mkdir -p /storage/_letsencrypt
chown www-data /storage/_letsencrypt
