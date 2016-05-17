#!/bin/bash

## Script to install Gitlab on Ubuntu 14.04

hostname=`hostname -f`
sudo apt-get update
echo "postfix postfix/mailname string ${hostname}"| sudo debconf-set-selections 
echo "postfix postfix/main_mailer_type string 'Internet Site'" | sudo debconf-set-selections

sudo apt-get install -y curl openssh-server ca-certificates postfix

pkg=/vagrant/gitlab-ce_8.7.5-ce.0_amd64.deb
# sudo curl -LJO https://packages.gitlab.com/gitlab/gitlab-ce/packages/ubuntu/trusty/${pkg}/download
sudo dpkg -i ${pkg}

sudo mkdir /etc/gitlab/ssl
sudo chmod 700 /etc/gitlab/ssl

openssl genrsa -out ${hostname}.key 2048

openssl req -new -key ${hostname}.key -out ${hostname}.csr \
  -extensions v3_ca \
  -subj "/C=US/ST=CA/O=Iono Inc/L=San Jose/OU=Iono Certs/CN=Universal CA root"

openssl x509 -req -days 3650 -in ${hostname}.csr -signkey ${hostname}.key \
  -out ${hostname}.crt

sudo cp ${hostname}.* /etc/gitlab/ssl

sudo sed -i.bak '/^external_url/ s:http:https:' /etc/gitlab/gitlab.rb

sudo gitlab-ctl reconfigure

# curl -k --header "PRIVATE-TOKEN: pzBxrBBpnUsjTsyV3yz9" https://gitlab.iono.box/api/v3/projects
# curl -k --header "PRIVATE-TOKEN: pzBxrBBpnUsjTsyV3yz9" -X POST "https://gitlab.iono.box/api/v3/projects?name=iono"
# curl -k --header "PRIVATE-TOKEN: pzBxrBBpnUsjTsyV3yz9" https://gitlab.iono.box/api/v3/projects
