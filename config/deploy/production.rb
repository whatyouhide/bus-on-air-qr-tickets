set :stage, :production
set :rails_env, :production

set :user, 'deploy'

# Shared ssh options.
set :ssh_options, { port: 54345 }

shared_properties = {
  user: fetch(:user),
  roles: %w(web app)
}

# Servers.
server '192.168.159.188', shared_properties
server 'whatyouhide.no-ip.me', shared_properties

# Where to deploy on each server.
set :deploy_to, "/home/#{fetch :user}/#{fetch :full_app_name}"
