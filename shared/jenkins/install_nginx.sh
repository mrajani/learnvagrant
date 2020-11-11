#!/bin/bash

echo ${1}
echo ${2}

if [[ ${1} =~ centos|redhat ]]; then
  echo Found Centos/Redhat
  sudo yum install -y -q epel-release
  sudo yum install -y -q nginx
  cp /vagrant/jenkins_nginx_centos.conf /etc/nginx/conf.d
  sudo systemctl start  nginx
  sudo systemctl enable nginx
  sudo systemctl status nginx
  sudo systemctl start  firewalld
  sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
  sudo firewall-cmd --zone=public --add-service=http  --permanent
  sudo firewall-cmd --zone=public --add-service=https --permanent
  sudo firewall-cmd --reload
  sudo firewall-cmd --list-all
else
  echo Found Debian/ubuntu
  sudo apt-get update -y
  sudo apt-get install -y nginx
  cp /vagrant/jenkins_nginx_ubuntu.conf /etc/nginx/conf.d
fi
