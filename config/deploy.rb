lock '3.2.1'

set :application, 'bus-on-air-qr-tickets'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :scm, :git
set :repo_url, 'https://github.com/whatyouhide/bus-on-air-qr-tickets.git'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/#{fetch :user}/#{fetch :full_app_name}"

set :rvm_type, :user
set :rvm_ruby_version, '2.1.2'

# Linked stuff.
set :linked_files, %w(db/production.sqlite3)
set :linked_dirs, %w(tmp/pids)

set :unicorn_config_path, 'config/unicorn.rb'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end
end
