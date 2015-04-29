#!/bin/bash

#
# This file just installs github keys in known_hosts
#

echo "Running ssh-keyscan"
for host in 192.30.252.128 192.30.252.129 192.30.252.130 192.30.252.131 \
    github.com gitlab.com bitbucket.org
do
  ssh-keyscan ${host} >> /home/vagrant/.ssh/known_hosts
done

cp /shared/gitconfig /home/vagrant/.gitconfig
cp /shared/ssh_id_rsa/* /home/vagrant/.ssh
cp /shared/ssh-config /home/vagrant/.ssh/config
sudo chown vagrant:vagrant /home/vagrant/.ssh/*
