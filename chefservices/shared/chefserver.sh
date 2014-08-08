#!/bin/bash

chefpkg=/home/vagrant/chef-server_11.1.1-1_amd64.deb

if [ -f $chefpkg ]; then
    sudo dpkg -i $chefpkg 
fi
sudo chef-server-ctl reconfigure
sudo chef-server-ctl test


if [ -d "/shared/.chef" ]; then
   sudo rm -rf /shared/.chef
fi

sudo mkdir /shared/.chef
sudo cp /etc/chef-server/{admin,chef-validator}.pem /shared/.chef
