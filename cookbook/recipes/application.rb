app_name = "feeder-web"

include_recipe "feeder-web::packages"
include_recipe "feeder-web::ffmpeg_delegates_fix"
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

include_recipe "gina-gluster::client"

node[app_name]['mounts'].each do |name, mnt|
  directory mnt['mount_point'] do
    recursive true
  end
  mount mnt['mount_point'] do
    device mnt['device']
    fstype mnt['fstype'] if mnt['fstype']
    options mnt['options'] if mnt['options']
    action mnt['action']
  end
end

node[app_name]['links'].each do |name, lnk|
  link lnk['name'] do
    to lnk['to']
    owner account
    group account
    action lnk['action']
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

template "#{node[app_name]['paths']['shared']}/config/secrets.yml" do
  owner account
  group account
  mode 00644
  variables({
    environment: node[app_name]['environment'],
    secrets: node[app_name]['secrets']
  })
end

template "#{node[app_name]['paths']['shared']}/config/default_url.yml" do
  owner account
  group account
  mode 00644
  variables({
    environments: node[app_name]['rails']['default_urls']
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
