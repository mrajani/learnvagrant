#!/bin/bash

echo "Running Provision.sh"

# Setting the time zone
echo "export TZ='America/Los_Angeles' " >> /home/vagrant/.bash_profile

# Set the colors in PuTTY term remove dark blue add Teal
echo 'export LS_COLORS=$(echo $LS_COLORS|sed "s/34/96/")' >> /home/vagrant/.bash_profile
