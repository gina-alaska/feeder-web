app_name = "feeder-web"

node[app_name]['packages'].each do |name, attr|
  package name do
    action attr['action']
    version attr['version'] if attr['version']
  end
end
