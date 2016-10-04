#!/bin/bash

#
# This file just installs github keys in known_hosts
#

user=vagrant
os=${1}
release=${2}
if [[ ${release} == "xenial" ]]; then
  user=ubuntu
fi

echo "Running ssh-keyscan"
for host in 192.30.252.128 192.30.252.129 192.30.252.130 192.30.252.131 \
    github.com gitlab.com bitbucket.org
do
  ssh-keyscan ${host} >> /home/${user}/.ssh/known_hosts
done

cp /shared/gitconfig /home/${user}/.gitconfig
cp /shared/ssh_id_rsa/* /home/${user}/.ssh
cp /shared/ssh-config /home/${user}/.ssh/config
sudo chown ${user}:${user} /home/${user}/.ssh/*
