#!/bin/bash

echo "Install Updates"
# sudo yum update -y
echo "Installing Puppet4 PuppetDB"
sudo yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum repolist
sudo yum update -y
sudo yum install -y puppet-agent puppetserver ntp

sudo systemctl enable ntpd
sudo systemctl start ntpd
sudo systemctl status ntpd

sudo firewall-cmd --list-all
sudo firewall-cmd --add-port=8140/tcp --permanent --zone=public
sudo firewall-cmd --add-service=ntp --permanent
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
## Adding  puppetlabs path to sudoers in secure_path when using sudo
sudo sed -i "/^Defaults.*secure_path*/ s,$,:/opt/puppetlabs/bin," /etc/sudoers
# Lower the jvm heap size
sudo sed -i "s/2g/1g/g" /etc/sysconfig/puppetserver
# From Learning Puppet 4
#sed -i -e 's#\(secure_path = .*\)$#\1:/opt/puppetlabs/bin#' /etc/sudoers
# sudo puppet master --version
sudo puppet resource package puppetdb ensure=latest
sudo puppet resource service puppetdb ensure=stopped enable=true
sudo puppet resource package puppetdb-termini ensure=latest
sudo puppet config print confdir

## Add a Test environment
## sudo mkdir -p /etc/puppetlabs/code/environments/test/{modules,hieradata,manifests}
## sudo mkdir -p /etc/puppetlabs/code/hieradata

## sudo puppet module install --environment test puppetlabs-ntp
## puppet module list --environment test --tree

## Run puppet master for debugging
## sudo groupadd puppet
## sudo useradd -m -d /var/opt/puppetlabs -g puppet puppet
## sudo /opt/puppetlabs/bin/puppet master --verbose --no-daemonize

## Install apache passenger
## sudo yum install -y epel-release
## sudo yum install -y httpd httpd-devel mod_ssl
## curl -sSLo passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo
## mv passenger.repo /etc/yum.repos.d
## sudo yum install -y passenger mod_passenger
## sudo passenger-config validate-install --validate-apache2 --auto

# sudo passenger-config validate-install --validate-apache2 --auto
# cd /etc/httpd/conf.d/
# for cfg in *.conf; do sudo mv $cfg ${cfg}.dis ; done
# sudo cp /vagrant/etc-puppet/puppetmaster.conf /etc/httpd/conf.d
# sudo mkdir -p /etc/puppetlabs/puppetmaster/public
# sudo cp /vagrant/etc-puppet/config.ru /etc/puppetlabs/puppetmaster/
# sudo chown puppet:puppet /etc/puppetlabs/puppetmaster/config.ru
# sudo mkdir /var/run/puppetlabs/puppetmaster
# sudo chown puppet:puppet /var/run/puppetlabs/puppetmaster
# sudo mkdir /var/log/puppetlabs/puppetmaster
# sudo chown puppet:puppet /var/log/puppetlabs/puppetmaster
# sudo systemctl restart httpd
# sudo systemctl status httpd

## wget http://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
## puppet module install puppetlabs-mongodb --target-dir modules
