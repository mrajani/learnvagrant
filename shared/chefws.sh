#!/bin/bash
#
# Install Chef Client for Ubuntu/CentOS
#

chefserver="chefserver12.iono.vm"

sudo cat > /etc/hosts <<EOH
127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain
::1       localhost localhost.localdomain localhost6 localhost6.localdomain
192.168.128.201 ${chefserver} chefserver12
192.168.128.202 chefws.iono.vm chefws
EOH

echo Installing Chef Client
curl -L https://www.opscode.com/chef/install.sh | sudo bash

dotchefdir=/home/vagrant/.chef
mkdir $dotchefdir; touch $dotchefdir/knife.rb
sudo chown -R vagrant:vagrant $dotchefdir

knife configure \
  --validation-client-name iono-org-validator \
  --validation-key /vagrant/iono-org-validator.pem  \
  --server-url https://${chefserver}/organizations/iono-org \
  --repository /home/vagrant/chef-repo \
  --user vagrant \
  --key /vagrant/vagrant.pem \
  --config .chef/knife.rb -y
knife ssl fetch

sudo knife client list
sudo knife user list
