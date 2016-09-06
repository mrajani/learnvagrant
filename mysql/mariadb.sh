#!/bin/bash

cp /vagrant/MariaDB.repo /etc/yum.repos.d
sudo yum install -y MariaDB-server MariaDB-client
