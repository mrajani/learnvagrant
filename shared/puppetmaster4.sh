#!/bin/bash

echo "Install Updates"
# sudo yum update -y
echo "Installing Puppet4 PuppetDB"
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
sudo yum install -y puppetserver git ntp

sudo chkconfig ntpd on
sudo chkconfig --list ntpd
sudo service ntpd start

## Adding new path to puppet in secure_path
sudo sed -i "/^Defaults.*secure_path*/ s,$,:/opt/puppetlabs/bin," /etc/sudoers

sudo puppet master --version
sudo puppet resource package puppetdb ensure=latest
sudo puppet resource service puppetdb ensure=running enable=true
sudo puppet resource package puppetdb-termini ensure=latest
sudo puppet config print confdir


# echo "Installing MCollective"
#sudo yum install -y mcollective \
#  mcollective-client \
#  java-1.6.0-openjdk \
#  activemq \
#  mcollective-puppet-agent \
#  mcollective-puppet-client

# For Production uses
echo "Installing Apache and Phusion Passenger"
