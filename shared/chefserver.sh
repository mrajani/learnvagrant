#!/bin/bash

dotchefdir="/shared/.chef"

chefpkg=/home/vagrant/chef-server_11.1.3-1_amd64.deb

if [ -f $chefpkg ]; then
    sudo dpkg -i $chefpkg
fi
sudo chef-server-ctl reconfigure
sudo chef-server-ctl test


if [ -d $dotchefdir ]; then
   sudo rm -rf $dotchefdir
fi

sudo mkdir $dotchefdir
sudo cp /etc/chef-server/{admin,chef-validator}.pem $dotchefdir
