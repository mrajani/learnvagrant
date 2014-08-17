#!/bin/bash

echo "Running apt-get update in silent mode"
sudo apt-get update -qq


echo Installing Chef Client
curl -L https://www.opscode.com/chef/install.sh | sudo bash

chefserver=192.168.128.40
# Set password to password

dotchefdir=/home/vagrant/.chef
sudo mkdir $dotchefdir
sudo chown -R vagrant:vagrant $dotchefdir
sudo cp /shared/.chef/*.pem $dotchefdir
sudo touch $dotchefdir/knife.rb

echo "vagrant" | sudo knife configure --initial \
     --admin-client-name admin --admin-client-key $dotchefdir/admin.pem \
     --validation-client chef-validator \
     --validation-key $dotchefdir/chef-validator.pem \
     --server-url https://${chefserver}:443 \
     --repository "/home/vagrant/chef-repo" \
     --user vagrant \
     --config $dotchefdir/knife.rb -y ### -VVV


sudo knife client list
sudo knife user list

# # Installing git
# echo "Installing git in silent mode, try to run chef-solo"
# sudo apt-get install -y -qq git
# echo "Running ssh-keyscan"
# ssh-keyscan github.com > /home/vagrant/.ssh/known_hosts 2>/dev/null
# sudo chown vagrant:vagrant /home/vagrant/.ssh/known_hosts
# echo "Running ssh -T"
# ssh -T git@github.com
# # ssh -T -oStrictHostKeyChecking=no git@github.com
# echo "Cloning chef-repo"
# echo "Login and run"
# echo "git clone git@github.com:mrajani/chef-repo.git"
# #
# # For some reason, git clone fails. get stderr out in vagrant
# # provisioner
# #
