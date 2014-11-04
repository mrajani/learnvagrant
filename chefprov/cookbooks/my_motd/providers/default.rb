action :create do
  log "Adding '#{new_resource.name}' greeting as #{new_resource.path}"
  file new_resource.path do
    content "#{new_resource.name}, #{new_resource.title}!\n"
    action :create
  end
end
