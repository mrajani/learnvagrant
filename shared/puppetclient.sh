#!/bin/bash

echo "$1 ${2}.iono.corp ${2}" >> /etc/hosts

sudo /bin/sed -i.old \
  "s/localhost.localdomain/${2}.iono.corp/" /etc/sysconfig/network

echo "Waiting for network service to restart"
sudo service network restart
sleep 15

sudo rpm -i http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sudo yum install -y puppet
