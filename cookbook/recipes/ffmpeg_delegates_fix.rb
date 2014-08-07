app_name = "feeder-web"
username = node[app_name]['account']
delegate_override = ::File.join('/home', username, '.magick', 'delegates.xml')

directory ::File.dirname(delegate_override) do
  user username
  group username
  action :create
end

template delegate_override do
  source "delegates.xml"
  action :create
  mode 00644
end

magic_shell_environment 'PATH' do
  value '$PATH:/opt/ffmpeg/bin'
end