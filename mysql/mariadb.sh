#!/bin/bash

cp /vagrant/MariaDB.repo /etc/yum.repos.d
sudo yum install -y epel-release
sudo yum -y update
sudo yum install -y MariaDB-server MariaDB-client
sudo yum install -y httpd php phpmyadmin

sudo systemctl start firewalld
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=mysql
sudo firewall-cmd --reload
sudo systemctl start httpd.service
sudo systemctl start mariadb.service

sudo systemctl enable httpd.service
sudo systemctl enable mariadb.service
sudo mysqladmin -u root password abcd1234
sed -i.bak '/<RequireAny>/{n;s/.*/Require all granted/;}' /etc/httpd/conf.d/phpMyAdmin.conf
sudo systemctl restart httpd.service

# Other firewall-cmd
# firewall-cmd --state
# firewall-cmd --list-all
# firewall-cmd --list-interfaces
# firewall-cmd --get-service
# firewall-cmd --query-service service_name
# firewall-cmd --add-port=8080/tcp
