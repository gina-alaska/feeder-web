default['unicorn_config_path'] = '/etc/unicorn'

default['feeder-web']['account'] = "webdev"
default['feeder-web']['environment'] = "production"
default['feeder-web']['packages'] = %w{
  ImageMagick-devel
}

#Path configuration
default['feeder-web']['paths'] = {
  application:   '/www/feeder-web',
  deploy:        '/www/feeder-web/current',
  shared:        '/www/feeder-web/shared',
  config:        '/www/feeder-web/shared/config',
  initializers:  '/www/feeder-web/shared/config/initializers',
  public:        '/www/feeder-web/shared/public',
  system:        '/www/feeder-web/shared/public/system'
}

#Rails Database configuration
default['feeder-web']['databases']['development'] = {
  database: 'feeder-web',
  adapter: 'postgresql',
  hostname: 'localhost',
  username: 'feeder-web_dev',
  password: nil,
  search_path: 'feederweb,public'
}

#Rails configuration
default['feeder-web']['secrets']['secret_key_base'] = 'b4b8fefeb6fc52226802bf3e293b250733b73d82388822a32d477a04ba4ce956dc251e656b3182ae8b21dbedce3c7d406488d12d2f4d4eaf4db40e115de3c675'
default['feeder-web']['rails']['application_class_name'] = ''
default['feeder-web']['rails']['default_urls'] = {
  development: 'localhost'
}
# default['feeder-web']['rails']['google_key'] = ""
# default['feeder-web']['rails']['google_secret'] = ""
# default['feeder-web']['rails']['github_key'] = ""
# default['feeder-web']['rails']['github_secret'] = ""

#Unicorn configuration
default['feeder-web']['unicorn'] = {
  preload_app: true,
  config_path: '/etc/unicorn/feeder-web.rb',
  listen:      '/www/feeder-web/shared/tmp/sockets',
  pid:         '/www/feeder-web/shared/tmp/pids/unicorn.pid',
  stdout_path: '/www/feeder-web/shared/log/unicorn.stdout.log',
  stderr_path: '/www/feeder-web/shared/log/unicorn.stderr.log',
  worker_timeout: 60,
  working_directory: '/www/feeder-web/current',
  before_fork: '
defined?(ActiveRecord::Base) and
   ActiveRecord::Base.connection.disconnect!

   old_pid = "#{server.config[:pid]}.oldbin"
   if old_pid != server.pid
     begin
       sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
       Process.kill(sig, File.read(old_pid).to_i)
     rescue Errno::ENOENT, Errno::ESRCH
     end
   end

sleep 1
  ',
  after_fork: '
defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
  '
}

#Redis
default['feeder-web']['redis']['url'] = "redis://localhost:6379/12"
default['feeder-web']['redis']['environment'] = "feeder_production"


#Sidekiq Configuration
default['feeder-web']['sidekiq']['action'] = [:enable]
default['feeder-web']['sidekiq']['pidfile'] = 'tmp/pids/sidekiq.pid'
default['feeder-web']['sidekiq']['concurrency'] = 1
default['feeder-web']['sidekiq']['environments'] = {
  'development' => {
    'concurrency' => 2
  }
}


#Mounts
default['feeder-web']['mounts'] = {
  'gvolfeeder_web_dev' => {
    'device' => 'pod2.gina.alaska.edu:/gvolfeeder_web_dev',
    'fstype' => 'glusterfs',
    'mount_point' => '/gluster/gvolfeeder_web_dev',
    'action' => [:mount, :enable]
  }
}

#Links
default['feeder-web']['links'] = {
  'dragonfly' => {'name' => '/www/feeder-web/shared/public/system/dragonfly', 'to' => '/gluster/gvolfeeder_web_dev/'}
}

#Database configuration
override['postgresql']['enable_pgdg_yum'] = true
override['postgresql']['version'] = "9.3"
override['postgresql']['dir'] = '/var/lib/pgsql/9.3/data'
override['postgresql']['client']['packages'] = %w{postgresql93 postgresql93-devel}
override['postgresql']['server']['packages'] = %w{postgresql93-server}
override['postgresql']['server']['service_name'] = 'postgresql-9.3'
override['postgresql']['contrib']['packages'] = %w{postgresql93-contrib}
