#!/bin/bash
sudo apt-get -y -q update
sudo apt-get install -y python3-pip
pip3 -qq install ansible pywinrm
