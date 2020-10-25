#!/usr/bin/env puma

directory '/home/ec2-user/sampo-log/current'
rackup "/home/ec2-user/sampo-log/current/config.ru"
environment 'production'

tag ''

pidfile "/home/ec2-user/sampo-log/shared/tmp/pids/puma.pid"
state_path "/home/ec2-user/sampo-log/shared/tmp/pids/puma.state"
stdout_redirect '/home/ec2-user/sampo-log/shared/log/puma_access.log', '/home/ec2-user/sampo-log/shared/log/puma_error.log', true


threads 0,16



bind 'unix:///home/ec2-user/sampo-log/shared/tmp/sockets/puma.sock'

workers 0





prune_bundler


on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = ""
end


