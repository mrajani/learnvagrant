#!/bin/bash
chefpkg=/home/vagrant/${1}

sudo yum check-update
sudo yum update -y && sudo yum install ntp crontabs -y

if [ -f $chefpkg ]; then
  sudo rpm -Uvh $chefpkg
  sudo rm $chefpkg
fi

sudo chef-server-ctl reconfigure
# sudo chef-server-ctl test

sudo chef-server-ctl install chef-manage
sudo chef-server-ctl reconfigure
sudo chef-manage-ctl reconfigure --accept-license

sudo chef-server-ctl install opscode-reporting
sudo chef-server-ctl reconfigure
sudo opscode-reporting-ctl reconfigure

sudo chef-server-ctl user-create vagrant Vagrant Admin 'vagrant@iono.corp' \
  vagrant -f vagrant.pem
sudo chef-server-ctl org-create iono-org Iono_Org -a vagrant \
    -f iono-org-validator.pem

cp /home/vagrant/{vagrant.pem,iono-org-validator.pem} /vagrant
