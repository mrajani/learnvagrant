#!/bin/bash

echo "Installing Puppet PuppetDB"
# sudo rpm -i /shared/puppet-rpms/*.rpm
sudo rpm -i http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

sudo yum install -y puppet-server puppet puppetdb puppetdb-terminus

echo "Installing MCollective"
sudo yum install -y mcollective \
  mcollective-client \
  java-1.6.0-openjdk \
  activemq \
  mcollective-puppet-agent \
  mcollective-puppet-client
