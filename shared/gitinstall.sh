#!/bin/bash

os=${1}

if [[ ${os} == "centos" ]]; then
  sudo yum install -y git
elif [[ ${os} == "ubuntu" ]]; then
  sudo apt-get install -y git
else
  exit
fi
