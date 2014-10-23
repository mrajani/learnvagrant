#
# Cookbook Name:: motd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# template "/var/run/motd" do
#   source "motd.erb"
#   mode "0644"
# end

cookbook_file "/home/vagrant/motd.cookbook.file" do
  mode '0644'
  owner 'vagrant'
  group 'root'
end


file '/home/vagrant/motd.file' do
  content "This is a content of motd.file"
end

template "/home/vagrant/motd" do
  source "motd.erb"
  mode '0755'
  owner 'root'
  group 'vagrant'
end
