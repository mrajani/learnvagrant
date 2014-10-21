#!/bin/bash
#
# Install Chef Client for Ubuntu
#

# echo "Running apt-get update in silent mode"
# sudo apt-get update -qq

echo Installing Chef Client
curl -L https://www.opscode.com/chef/install.sh | sudo bash

chefserver=192.168.128.40
# Set password to password

dotchefdir=/home/vagrant/.chef
mkdir $dotchefdir
cp /shared/.chef/*.pem $dotchefdir
touch $dotchefdir/knife.rb
sudo chown -R vagrant:vagrant $dotchefdir

echo "vagrant" | knife configure --initial \
     --admin-client-name admin --admin-client-key $dotchefdir/admin.pem \
     --validation-client chef-validator \
     --validation-key $dotchefdir/chef-validator.pem \
     --server-url https://${chefserver}:443 \
     --repository "/home/vagrant/chef-repo" \
     --user vagrant \
     --config $dotchefdir/knife.rb -y ### -VVV

sudo knife client list
sudo knife user list
