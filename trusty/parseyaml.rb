# -*- mode: ruby -*-
# vi: set ft=ruby :

# read vm and chef configurations from JSON files
require 'yaml'
require 'pp'
node = YAML.load_file(File.join(File.dirname(__FILE__), 'vagrant.yml'))[0]

puts node['hostname']

node['provisioners']['shell'] && node['provisioners']['shell'].each do |script|
  puts "============="
  puts script['path']
  puts script['args'] if defined?(script['args'])
end
