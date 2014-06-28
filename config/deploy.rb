lock '3.2.1'

set :application, 'bus-on-air-qr-tickets'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :scm, :git
set :repo_url, 'https://github.com/whatyouhide/bus-on-air-qr-tickets.git'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/#{fetch :user}/#{fetch :full_app_name}"

set :rvm_type, :user
set :rvm_ruby_version, '2.1.2'



# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w(tmp/pids)

set :unicorn_config_path, 'config/unicorn.rb'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end
end
