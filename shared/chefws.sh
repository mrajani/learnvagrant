#!/bin/bash
#
# Install Chef Client for Ubuntu/CentOS
#

chefserver="chefserver12.iono.vm"

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
