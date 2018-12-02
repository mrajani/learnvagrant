#!/bin/bash

echo ${1}
echo ${2}

if [[ ${1} =~ centos|redhat ]]; then
  echo Found Centos/Redhat
  sudo yum install -y -q curl policycoreutils openssh-server openssh-clients
  sudo systemctl enable sshd
  sudo systemctl start sshd
  sudo yum -y install postfix
  sudo systemctl enable postfix
  sudo systemctl start postfix
  sudo firewall-cmd --permanent --add-service=http
  sudo systemctl reload firewalld
  curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
  sudo EXTERNAL_URL="http://192.168.128.58" yum install -y gitlab-ce

else
  echo Found Debian/ubuntu
fi
