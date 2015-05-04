#!/bin/bash

# Download java cookbook
mkdir -p chef/cookbooks
knife cookbook site download java
# tar zxf java.xxxx.tar.gz -C chef/cookbooks
# install oracle java
# chef-solo -c solo.rb -j java.json
cp -r /shared/chef-solo .

# Prepare for Jenkins, Nginx install
sudo wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key \
   | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > \
   /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins nginx unzip

sudo rm /etc/nginx/sites-enabled/default
sudo cp /vagrant/jenkins-nginx /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/jenkins-nginx /etc/nginx/sites-enabled/

# Clone git repo
git clone git@github.com:mrajani/springtrader.git
wget http://dl.bintray.com/groovy/maven/groovy-binary-2.4.0.zip
sudo unzip groovy-binary-2.4.0.zip -d /opt
sudo ln -s /opt/groovy-2.4.0 /opt/groovy
export PATH=${PATH}:/opt/groovy/bin


cat <<EOL >> ~/.ssh/config
at << EOL >> blah
Host ntphost
Hostname 192.168.128.162
IdentityFile ~/.ssh/jenkins_rsa
User vagrant
EOL

ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/jenkins_rsa
ssh-copy-id -i .ssh/jenkins_rsa vagrant@192.168.128.162

