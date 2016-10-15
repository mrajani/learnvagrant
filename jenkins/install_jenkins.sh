#!/bin/bash

echo ${1}
echo ${2}

if [[ ${1} =~ centos|redhat ]]; then
  echo Found Centos/Redhat
  sudo yum install -y -q java-1.8.0-openjdk
  sudo wget -O /etc/yum.repos.d/jenkins.repo \
    http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
  sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
  sudo yum install -y -q jenkins
  # Disable setup wizard - unsafe for production
  # sed -ie '/^JENKINS_JAVA_OPTIONS=/ s#"\(.*\)\"#"\1 -Djenkins.install.runSetupWizard=false"#' \
  #  /etc/sysconfig/jenkins
  sudo systemctl start  jenkins
  sudo systemctl enable jenkins
  sudo systemctl status jenkins
  sudo systemctl start  firewalld
  sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
  sudo firewall-cmd --zone=public --add-service=http --permanent
  sudo firewall-cmd --reload
  sudo firewall-cmd --list-all
else
  echo Found Debian/ubuntu
  sudo apt-get install -y openjdk-8-jdk
  wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | \
    sudo apt-key add -
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ \
    > /etc/apt/sources.list.d/jenkins.list'
  sudo apt-get -y update
  sudo apt-get install -y jenkins
fi

export JENKINS_URL=http://localhost:8080
ssh-keygen -t rsa -b 2048 -N "" -f ~/.ssh/id_rsa_jenkins
# copy id_rsa_jenkins.pub to jenkinsadmin SSH public keys
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
# Enable jnlp agents port to 18080
# java -jar /home/vagrant/jenkins-cli.jar -i ~/.ssh/id_rsa_jenkins \
#    install-plugin publish-over-ssh vmware-vrealize-orchestrator \
#    vmware-vrealize-automation-plugin gitlab-plugin vsphere-cloud
