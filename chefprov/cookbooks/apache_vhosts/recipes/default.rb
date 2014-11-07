# create VirtualHosts
node['apache_vhosts'].each{|vhost|
	web_app vhost['app'] do
		template 'vhost.erb'
		docroot vhost['path']
		server_name vhost['server_name']
		server_email vhost['server_email']
		server_alias vhost['server_alias']
		port vhost['port']
	end
}

# cookbook_file "/home/vagrant/motd.cookbook.file" do
#   mode '0644'
#   owner 'vagrant'
#   group 'root'
# end
#
#
#file '/home/vagrant/motd.file' do
#   content "This is a content of motd.file"
# end
#
# template "/home/vagrant/motd" do
#   source "motd.erb"
#   mode '0755'
#   owner 'root'
#   group 'vagrant'
# end
