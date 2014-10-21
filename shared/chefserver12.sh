#!/bin/bash

dotchefdir="/shared/.chef"

chefpkg=/home/vagrant/${1}

sudo yum check-update
sudo yum update -y && sudo yum install ntp crontabs -y

if [ -f $chefpkg ]; then
  sudo rpm -Uvh $chefpkg
fi


sudo chef-server-ctl reconfigure
sudo chef-server-ctl test
sudo chef-server-ctl user-create vagrant vagrant vagrant 'vagrant@iono.corp' \
    vagrant -f vagrant.pem

sudo chef-server-ctl install opscode-manage
sudo opscode-manage-ctl reconfigure
sudo chef-server-ctl reconfigure

sudo chef-server-ctl org-create iono-org Iono_Org -a vagrant -f iono-org.pem


# sudo yum check-update
# sudo yum update -y && sudo yum install ntp crontabs -y
# sudo rpm -Uvh chef-server-core-12.0.0_rc.4-1.el5.x86_64.rpm
# sudo chef-server-ctl reconfigure
# sudo chef-server-ctl test
# sudo chef-server-ctl install opscode-manager
# sudo opscode-manage-ctl reconfigure
# sudo chef-server-ctl reconfigure
