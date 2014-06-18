app_name = "feeder-web"

node[app_name]['packages'].each do |pkg|
  package pkg
end
