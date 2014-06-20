# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'feeder-web'
set :repo_url, 'git@github.com:gina-alaska/feeder-web.git'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/www/feeder-web'
set :scm, :git
set :format, :pretty
set :log_level, :debug
# set :pty, true
set :linked_files, %w{config/database.yml config/secrets.yml config/sidekiq.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system}
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :keep_releases, 5
set :unicorn_config, "/etc/unicorn/feeder-web.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :kill, '-USR2', "`cat #{release_path.join('tmp/pids/unicorn.pid')}`"
    end
  end

  # after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  after :finishing, 'deploy:cleanup'
end
