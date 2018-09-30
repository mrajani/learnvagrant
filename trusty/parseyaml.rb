# -*- mode: ruby -*-
# vi: set ft=ruby :

# read vm and chef configurations from JSON files
require 'yaml'
require 'pp'
nodes = YAML.load_file(File.join(File.dirname(__FILE__), 'vagrant.yml'))['nodes']


node = YAML.load_file(File.open("vagrant.yml"))['nodes']

node['shared'].each do |sh|
  puts sh
  puts "/#{sh}"
end
