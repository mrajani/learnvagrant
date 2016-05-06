#!/bin/bash

release=puppetlabs-release-pc1-trusty.deb
wget http://apt.puppetlabs.com/${release}
sudo dpkg -i ${release}
sudo apt-get update
sudo apt-get install -y puppet-agent
echo 'export PATH=/opt/puppetlabs/bin:${PATH}' >> /home/vagrant/.bash_profile
/opt/puppetlabs/bin/puppet module install puppetlabs-mongodb \
    --target-dir /vagrant/modules
