#!/bin/bash


sudo apt-get update
sudo apt-get install -y git

echo Installing Chef Client
curl -L https://www.opscode.com/chef/install.sh | sudo bash

chefserver=192.168.128.40
# Set password to password

sudo mkdir /home/vagrant/.chef
sudo cp /shared/.chef/*.pem /home/vagrant/.chef
sudo touch /home/vagrant/.chef/knife.rb

echo "vagrant" | sudo knife configure --initial \
     --admin-client-name admin --admin-client-key ./.chef/admin.pem \
     --validation-client chef-validator \
     --validation-key ./.chef/chef-validator.pem \
     --server-url https://${chefserver}:443 \
     --repository "/home/vagrant/chef-repo" \
     --user vagrant \
     --config ./.chef/knife.rb -y \
     -VVV

sudo knife client list
sudo knife user list
