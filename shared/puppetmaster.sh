#!/bin/bash

echo "$1 ${2}.iono.corp ${2} puppet" >> /etc/hosts

sudo /bin/sed -i.old \
  "s/localhost.localdomain/${2}.iono.corp/" /etc/sysconfig/network


echo "Waiting for network service to restart"
sudo service network restart
sleep 15

echo "Installing Puppet PuppetDB"
# sudo rpm -i /shared/puppet-rpms/*.rpm
sudo rpm -i http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sudo yum install -y puppet-server puppet
   # puppetdb puppetdb-terminus

echo "Installing MCollective"
sudo yum install -y mcollective \
  mcollective-client \
  java-1.6.0-openjdk \
  activemq \
  mcollective-puppet-agent \
  mcollective-puppet-client
