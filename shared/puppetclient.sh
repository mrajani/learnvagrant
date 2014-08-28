#!/bin/bash


puppetmasterip='192.168.128.50'
echo "$1 ${2}.${3} ${2}" >> /etc/hosts
echo "${puppetmasterip} puppet.${3} puppet" >> /etc/hosts

sudo /bin/sed -i.old \
  "s/localhost.localdomain/${2}.${3}/" /etc/sysconfig/network

echo "Waiting for network service to restart"
sudo service network restart
sleep 15

sudo rpm -i http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sudo yum install -y puppet git
