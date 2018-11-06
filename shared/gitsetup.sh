#!/bin/bash

#
# This file just installs github keys in known_hosts
#

user=vagrant
if [[ ! -z "${2}" ]]; then
  user=${2}
fi

echo "Running ssh-keyscan"
for host in github.com gitlab.com bitbucket.org
do
  ssh-keyscan ${host} >> /home/${user}/.ssh/known_hosts
done

cp /shared/gitconfig /home/${user}/.gitconfig
cp /shared/ssh_id_rsa/* /home/${user}/.ssh
cp /shared/ssh-config /home/${user}/.ssh/config
sudo chown ${user}:${user} /home/${user}/.ssh/*
