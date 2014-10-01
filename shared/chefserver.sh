#!/bin/bash

dotchefdir="/shared/.chef"

chefpkg=/home/vagrant/${1}

if [[ ${2} == "centos" && -f $chefpkg ]]; then
  sudo rpm -ivh $chefpkg
elif [[ ${2} == "ubuntu" && -f $chefpkg ]]; then
  sudo dpkg -i $chefpkg
else
  exit
fi

sudo chef-server-ctl reconfigure
sudo chef-server-ctl test


if [ -d $dotchefdir ]; then
   sudo rm -rf $dotchefdir
fi

sudo mkdir $dotchefdir
sudo cp /etc/chef-server/{admin,chef-validator}.pem $dotchefdir
