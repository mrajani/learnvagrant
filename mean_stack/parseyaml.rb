# -*- mode: ruby -*-
# vi: set ft=ruby :

# read vm and chef configurations from JSON files
require 'yaml'
require 'pp'
nodes = YAML.load_file(File.join(File.dirname(__FILE__), 'vagrant.yml'))['nodes']

pp nodes
ports = nodes[0]['provisioners']['ports'] # ports is an array
ports.each do |port| # port is a hash
  port.each do |proto, value| 
    puts "#{proto} - host #{value['host']} - guest #{value['guest']}"
  end
end

