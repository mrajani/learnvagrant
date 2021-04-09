#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y -q update 2>&1 1>/dev/null
echo Install python3-pip
sudo apt-get install -y python3-pip 2>&1 1>/dev/null
echo Install Ansible
pip3 -qq install ansible pywinrm
