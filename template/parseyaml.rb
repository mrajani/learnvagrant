# -*- mode: ruby -*-
# vi: set ft=ruby :

# read vm and chef configurations from JSON files
require 'yaml'
require 'pp'
nodes = YAML.load_file(File.join(File.dirname(__FILE__), 'vagrant.yml'))['nodes']

nodes.each do |node|
  ports = node['provisioners']['ports'] # ports is an array
  # pp ports
  ports.each do |proto, value| # port is a hash
      puts "#{node['hostname']} #{proto} - host #{value['host']} - guest #{value['guest']}"
  end

  shells = node['provisioners']['shell'] # shells is an array
  # pp shells
  shells.each do |script, value| # shell is a hash
    puts "#{script} #{value}"
  end


  dirs = node['provisioners']['mntdir'] # dirs is an array
  # pp dirs
  dirs.each do |mounted, value| # dir is a hash
    puts "#{mounted} #{value}"
  end

  puts '================================'

=begin
  if node['provisioners']['mntdir']
    mntdirs = node['provisioners']['mntdir']
    mntdirs.each do |mntdir|
      mntdir.each do |key, value|
        puts "#{key} mounted on #{value}"
      end
      end
    end=end
    puts '================================'
=end
end

