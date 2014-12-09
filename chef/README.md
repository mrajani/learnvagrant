The Vagrantfile deploys Chef Server 12 and Chef Workstation. 
The configuration for server and workstation are driven by a yaml file.
There are more optimizations that could be made, however, I wanted to 
maintain readability over efficicency. 

It creates an org and a user in Chef Server 12, creates knife.rb in Chef 
workstation. Then validate the knife.rb is setup correctly.


