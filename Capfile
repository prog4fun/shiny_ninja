# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Include Capistrano-Rails
require 'capistrano/rails'

# Include Capistrano-RVM
require 'capistrano/rvm'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
# https://github.com/capistrano/rvm
# https://github.com/capistrano/rbenv
# https://github.com/capistrano/chruby
# https://github.com/capistrano/bundler
# https://github.com/capistrano/rails
#
# require 'capistrano/rvm'
# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
