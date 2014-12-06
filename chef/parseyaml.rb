# -*- mode: ruby -*-
# vi: set ft=ruby :

# read vm and chef configurations from JSON files
require 'yaml'
require 'pp'

def shell_provisioner_args(yaml_arguments)
  shell_arguments = Array.new

  # Arguments may or may not be named,
  # and named arguments may or may not have a value.
  yaml_arguments.each do |argument|
    argument.key?('name') && shell_arguments.push(argument['name'])
    argument.key?('value') && shell_arguments.push(argument['value'])
  end

  shell_arguments
end

config = YAML.load_file(File.open("vagrant.chef.yml"))
nodes = config['nodes']


nodes && nodes.each do |node, node_details|
  node_name   = node # name of node

  puts "____ node_name #{node_name} _____"

  provisioners = node_details['provisioners']

  provisioners && provisioners.each do |prov_type, prov_details|
    if prov_type == 'file'
      pp provisioners
    elsif prov_type == 'shell'
      prov_details.each do |provisioner|
        provisioner.each do |key, value|
          if key == 'arguments'
            p "key #{key} Shell Args ", shell_provisioner_args(value)
          else
            puts "key #{key} #{value}"
          end
        end
      end
    end
  end
end
