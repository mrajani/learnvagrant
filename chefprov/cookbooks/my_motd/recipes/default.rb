#
# Cookbook Name:: greeting
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

my_motd "hello" do
  title "world"
  action :create
end

my_motd_dirs do
  deploy_to "dir1"
  action 'create'
end
