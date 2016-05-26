#!/bin/bash

echo "Install Updates"
# sudo yum update -y
echo "Installing Puppet4 PuppetDB"
sudo yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum repolist
sudo yum install -y puppet-agent puppetserver ntp

sudo systemctl enable ntpd
sudo systemctl start ntpd
sudo systemctl status ntpd

sudo firewall-cmd --list-all
sudo firewall-cmd --add-port=8140/tcp --permanent --zone=public
sudo firewall-cmd --add-service=ntp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all


## Adding  puppetlabs path to sudoers in secure_path when using sudo
sudo sed -i "/^Defaults.*secure_path*/ s,$,:/opt/puppetlabs/bin," /etc/sudoers
# From Learning Puppet 4
#sed -i -e 's#\(secure_path = .*\)$#\1:/opt/puppetlabs/bin#' /etc/sudoers


# sudo puppet master --version
sudo puppet resource package puppetdb ensure=latest
sudo puppet resource service puppetdb ensure=running enable=true
sudo puppet resource package puppetdb-termini ensure=latest
sudo puppet config print confdir

## Run puppet master for debugging
## sudo /opt/puppetlabs/bin/puppet master --verbose --no-daemonize
## wget http://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
## puppet module install puppetlabs-mongodb --target-dir modules
