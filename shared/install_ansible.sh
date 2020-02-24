#!/bin/bash

if [[ ( -z ${os} && -z ${dist} ) ]]; then
  if [ -e /etc/os-release ]; then
    . /etc/os-release
    os=$( echo ${ID} | awk '{ print tolower($1) }')
    dist=${VERSION_ID}
  fi
fi
echo "Found ${os} "

if [[ ${os} == "centos" ]]; then
  # Install Ansible in CentOS
  echo This is Centos  
elif [[ ${os} == "ubuntu" ]]; then
  # Install Ansible in Ubuntu 18.04
  sudo apt update -y 2>/dev/null 1>&2
  sudo apt install -yq software-properties-common 2>/dev/null 1>&2
  sudo apt-add-repository -y ppa:ansible/ansible 2>/dev/null 1>&2
  sudo apt update -y 2>/dev/null 1>&2
  sudo apt install -y ansible 2>/dev/null 1>&2
  echo Installed Ansible on Ubuntu $VERSION
  ansible --version
elif [[ ${os} == "amzn" ]]; then
  echo This is Amazon Linux
else
  echo "Cannot identify the OS"
fi

cp /Scratch/ansible.cfg ~/.ansible.cfg
