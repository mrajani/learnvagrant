#!/bin/bash

sudo rpm -ivh \
  http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
sudo yum install -y ansible

ssh-keygen -t rsa -b 2048 -f /home/vagrant/.ssh/ansible

git clone https://github.com/glenjarvis/ansible_tutorial
