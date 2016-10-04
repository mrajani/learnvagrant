#!/bin/bash

os=${1}
release=${2}
echo "Puppet Agent for ${1} and release ${2}"
if [[ ${os} == "centos" ]]; then
  echo "----> Install Updates, Puppet4 Agent <----"
  sudo yum update -y
  sudo yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
  sudo yum repolist
  sudo yum install -y puppet-agent
  # sudo sed -i "/^Defaults.*secure_path*/ s,$,:/opt/puppetlabs/bin," /etc/sudoers
  # sudo service puppet start
elif [[ ${os} == "ubuntu" ]]; then
  echo "----> Download deb package, update, Puppet4 Agent <----"
  pkg=puppetlabs-release-pc1-${release}.deb
  wget http://apt.puppetlabs.com/${pkg}
  sudo dpkg -i ${pkg}
  sudo apt-get update && sudo apt-get install -y puppet-agent
  sudo sed -i -e '/secure_path/ s/"//g' \
      -e '/secure_path/ s#\(.*\)#\1:/opt/puppetlabs/bin#' /etc/sudoers
  # sudo /opt/puppetlabs/bin/puppet agent --enable
  # sudo service puppet start
else
  exit
fi
