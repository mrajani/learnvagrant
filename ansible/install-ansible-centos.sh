#!/bin/bash

sudo yum install -q -y epel-release.noarch
sudo yum install -y ansible

ssh-keygen -t rsa -b 2048 -f /home/vagrant/.ssh/ansible -N ""
# run ssh-copy-id -i ansible vagrant@node-188
# verify run ssh -i ansible vagrant@node-188
git clone https://github.com/glenjarvis/ansible_tutorial
