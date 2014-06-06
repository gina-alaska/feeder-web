app_path "/www/feeder-web/current"
chruby.environment 1.9
startup ['bundle install', 'service unicorn_feeder-web start']
