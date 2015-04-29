#!/bin/bash

mkdir -p chef/cookbooks
knife cookbook site download java
# tar zxf java.xxxx.tar.gz -C chef/cookbooks
# install oracle java
chef-solo -c solo.rb -j java.json

sudo wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins


sudo cp /shared/jenkins/jenkins-nginx /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/jenkins-nginx /etc/nginx/sites-enabled/

git clone git@github.com:mrajani/springtrader.git
wget http://dl.bintray.com/groovy/maven/groovy-binary-2.4.0.zip
unzip groovy-binary-2.4.0.zip -d /opt
sudo ln -s /opt/groovy-2.4.0 /opt/groovy
