#!/bin/bash

echo "----> Install Updates <----"
sudo yum update -y -q
echo "----> Install Puppet4 PuppetDB <-----"
yum_puppet_url=https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
sudo yum install -y ${yum_puppet_url}
sudo yum repolist
sudo yum install -y -q puppetserver ntp

sudo systemctl enable ntpd
sudo systemctl start  ntpd
sudo systemctl status ntpd
sudo systemctl enable puppetserver
sudo systemctl start  puppetserver
sudo systemctl status puppetserver
sudo systemctl enable firewalld
sudo systemctl start  firewalld
sudo systemctl status firewalld

sudo firewall-cmd --list-all
sudo firewall-cmd --add-port=8140/tcp --permanent --zone=public
sudo firewall-cmd --add-service=ntp --permanent
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
## Adding  puppetlabs path to sudoers in secure_path when using sudo
# sed -i -e 's#\(secure_path = .*\)$#\1:/opt/puppetlabs/bin#' /etc/sudoers
sudo sed -i "/^Defaults.*secure_path*/ s,$,:/opt/puppetlabs/bin," /etc/sudoers
# Lower the jvm heap size
sudo sed -i "s/2g/1g/g" /etc/sysconfig/puppetserver
# Not for prod
echo "*.iono.*" | sudo tee /etc/puppetlabs/puppet/autosign.conf
# sudo puppet master --version
# Add eyaml
sudo /opt/puppetlabs/bin/puppetserver gem install hiera-eyaml

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


## wget http://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
## puppet module install puppetlabs-mongodb --target-dir modules
