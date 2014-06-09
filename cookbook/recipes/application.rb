app_name = "feeder-web"

include_recipe "feeder-web::packages"
include_recipe "feeder-web::ruby"
include_recipe "postgresql::client"

account = node[app_name]['account']
user account

node[app_name]['paths'].each do |name, path|
  directory path do
    owner account
    group account
    mode 00755
    action :create
    recursive true
  end
end

template "#{node[app_name]['paths']['shared']}/config/database.yml" do
  owner account
  group account
  mode 00644
  variables({
    databases: node[app_name]['databases']
  })
end

directory "/home/#{account}/.bundle" do
  owner account
  group account
  mode 00755
  action :create
end

template "/home/#{account}/.bundle/config" do
  source "bundle/config.erb"
  owner account
  group account
  variables({version: node['postgresql']['version']})
  mode 00644
end

%w{log tmp system tmp/pids tmp/sockets}.each do |dir|
  directory "#{node[app_name]['paths']['shared']}/#{dir}" do
    owner node[app_name]['account']
    group node[app_name]['account']
    mode 0755
  end
end

link "/home/#{account}/#{app_name}" do
  to node[app_name]['paths']['deploy']
  owner node[app_name]['account']
  group node[app_name]['account']
end
