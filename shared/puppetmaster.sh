#!/bin/bash

echo "Installing Puppet"
sudo rpm -i /shared/puppet-rpms/*.rpm

echo "Complete Puppet Install"

echo sudo yum Install yum-downloadonly
echo yum install puppet --downloadonly --downloaddir=.
