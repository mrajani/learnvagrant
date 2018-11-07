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
  sudo yum install -q -y epel-release.noarch
  sudo yum install -q -y git unzip
elif [[ ${os} == "ubuntu" ]]; then
  sudo apt-get update && sudo apt-get install -y git
else
  echo "Cannot identify the OS"
fi
