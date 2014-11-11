define :my_motd_dirs, :deploy_to => '', :action => 'create' do

  log "the action is #{params[:action]}"
  directory "/home/vagrant/my_motd/#{params[:deploy_to]}" do
    action "#{params[:action]}"
    recursive true
  end

  directory "/home/vagrant/my_motd" do
    action "#{params[:action]}"
    recursive true
  end

end
