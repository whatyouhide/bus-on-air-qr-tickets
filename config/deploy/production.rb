set :stage, :production
set :rails_env, :production

# Server.
server 'qrtickets.andrealeopardi.com',
  user: fetch(:user),
  roles: %w(web app)
