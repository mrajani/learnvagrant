#!/bin/bash

#
# This file just installs github keys in known_hosts
#

echo "Running ssh-keyscan"
for host in 192.30.252.128 192.30.252.129 192.30.252.130 github.com
do
  ssh-keyscan ${host} >> /home/vagrant/.ssh/known_hosts
done

sudo chown vagrant:vagrant /home/vagrant/.ssh/known_hosts

echo "Running ssh -T"
ssh -T git@github.com
## ssh -T -oStrictHostKeyChecking=no git@github.com
# echo "Cloning chef-repo"
# echo "Login and run"
# echo "git clone git@github.com:mrajani/chef-repo.git"
exit 0
