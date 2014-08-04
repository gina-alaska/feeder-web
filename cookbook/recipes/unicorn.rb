app_name = "feeder-web"
user node[app_name]['account']

directory node[app_name]['unicorn']['listen'] do
  user node[app_name]['account']
  group node[app_name]['account']
  recursive true
  action :create
end

workers = node[app_name]['unicorn']['worker_processes'] ||
          [node['cpu']['total'].to_i * 4, 8].min

unicorn_config node[app_name]['unicorn']['config_path'] do
  # preload_app node[app_name]['unicorn']['preload_app']
  preload false
  listen "#{node[app_name]['unicorn']['listen']}/#{app_name}.socket" => {backlog: 1024}
  pid node[app_name]['unicorn']['pid']
  stderr_path node[app_name]['unicorn']['stderr_path']
  stdout_path node[app_name]['unicorn']['stdout_path']
  worker_timeout node[app_name]['unicorn']['worker_timeout']
  worker_processes workers
  working_directory node[app_name]['unicorn']['deploy_path']
  before_fork node[app_name]['unicorn']['before_fork']
  after_fork node[app_name]['unicorn']['after_fork']
end

template "/etc/init.d/unicorn" do
  source "unicorn_init.erb"
  action :create
  mode 00755
  variables({
    install_path: node[app_name]['paths']['deploy'],
    user: node[app_name]['account'],
    unicorn_config_file: node[app_name]['unicorn']['config_path'],
    environment: node[app_name]['environment'],
    ruby_version: node[app_name]['ruby_version'],
    redis_url: node[app_name]['redis']['url'],
    redis_environment: node[app_name]['redis']['environment']
  })
end

service "unicorn" do
  action [:enable, :start]
end

service "unicorn_#{app_name}" do
  action [:stop, :disable]
end

file "/etc/init.d/unicorn_#{app_name}" do
  action :delete
end