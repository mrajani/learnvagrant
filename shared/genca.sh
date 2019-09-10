#!/bin/bash

#---- Script to Generate Self Signed Certs ----#

hostname=`hostname -s`
openssl genrsa -out ${hostname}.key 2048
openssl req -new -key ${hostname}.key -out ${hostname}.csr \
  -extensions v3_ca \
  -subj "/C=US/ST=CA/O=JustDoIt/L=San Jose/OU=JustDoIt/CN=Universal CA root"
openssl x509 -req -days 90 -in ${hostname}.csr -signkey ${hostname}.key \
  -out ${hostname}.crt
