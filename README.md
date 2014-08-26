Learning Vagrant by way of Chef Server Deployment

All Shell Scripts are in ./shared folder, which is mounted on the VM.

All Chef setup are for Ubuntu versions 1[2|4].04

chefserver.sh installs the open source chef server

chefclient.sh installs chef client and creates an user 'vagrant'
in chef.

chefnodes - installs a plain node to manage from chef server

See notes.
