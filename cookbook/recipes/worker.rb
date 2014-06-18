include_recipe 'feeder-web::application'

app_name = "feeder-web"

template "/etc/init.d/sidekiq_#{app_name}" do
  source "sidekiq_init.erb"
  action :create
  mode 00755
  variables({
    install_path: node[app_name]['paths']['deploy'],
    ruby_version: node[app_name]['ruby_version'],
    user: node[app_name]['account'],
    environment: node[app_name]['environment']
  })
end

service "sidekiq_#{app_name}" do
  action node[app_name]['sidekiq']['action']
end
