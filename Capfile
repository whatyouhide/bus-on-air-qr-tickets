# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Helpers
require 'capistrano/rvm'
require 'capistrano/bundler'

# Rails
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

# Unicorn
require 'capistrano3/unicorn'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
