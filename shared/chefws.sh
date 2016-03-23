#!/bin/bash
#
# Install Chef Client for Ubuntu/CentOS
#

chefserver="chefserver12.iono.vm"
chefdkpkg=/home/vagrant/${1}

sudo yum check-update
sudo yum update -y && sudo yum install ntp crontabs -y

echo Installing Chef Client
if [ -f $chefdkpkg ]; then
  sudo rpm -Uvh $chefdkpkg
  sudo rm $chefdkpkg
fi


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
knife ssl check

sudo knife client list
sudo knife user list


# debugging plural sight
# chef verify
# chef gem list chef-config
# chef gem list chef-config -ra
# knife cookbook create lab-linux
# chef generate repo chef-repo
# chef generate cookbook sample-cookbook
# berks
# berks install
# berks upload -no-ssl-verify
# knife node run_list add a49 'role[lab-linux]'
# knife node run_list remove a49 'role[lab-linux]'
