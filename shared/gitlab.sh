#!/bin/bash

## Script to install Gitlab on Ubuntu 14.04

sudo apt-get update
sudo debconf-set-selections <<< "postfix postfix/mailname string `hostname -f`"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo apt-get install -y curl openssh-server ca-certificates postfix

pkg=gitlab-ce_8.7.5-ce.0_amd64.deb
sudo curl -LJO https://packages.gitlab.com/gitlab/gitlab-ce/packages/ubuntu/trusty/${pkg}/download
sudo dpkg -i ${pkg}
sudo gitlab-ctl reconfigure

hostname=`hostname -f`
sudo mkdir /etc/gitlab/ssl
sudo chmod 700 /etc/gitlab/ssl

openssl genrsa -out ${hostname}.key 2048

openssl req -new -key ${hostname}.key -out ${hostname}.csr \ 
  -extensions v3_ca \
  -subj "/C=US/ST=CA/O=Iono Inc/L=San Jose/OU=Iono Certs/CN=Universal CA root"
openssl x509 -req -days 3650 -in ${hostname}.csr -signkey ${hostname}.key \
  -out ${hostname}.crt 

sudo cp `hostname -f`.* /etc/gitlab/ssl
