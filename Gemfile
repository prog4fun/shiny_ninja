source 'https://rubygems.org'

gem 'rails', '4.1.1'

# Database (mySQL for production, sqlite for development):
gem 'mysql2', :group => [:staging, :production]
gem 'sqlite3', :group => [:development, :test]


# Standards:
gem 'uglifier'
gem 'sass-rails', '~> 4.0.3'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'therubyracer', :platforms => :ruby
gem 'turbolinks'
gem 'sdoc', :require => false, :group => [:doc]
# Improved (JavaDoc like) documentation
gem 'yard'


group :development, :test do
# Faster than Webrick:
  gem 'puma'
# Debugging in console:
  gem 'pry-rails'
# No output of asset in server logfile:
  gem 'quiet_assets'
# More infomration in error-pages, live console:
  gem 'better_errors'
  gem 'binding_of_caller'
# Structured output of inspect, ap(<>).html_safe:
  gem 'awesome_print'
# Testing:
  gem 'rspec-rails', '~> 3.0.0' #Update! (https://github.com/rspec/rspec-rails)
  gem 'fuubar'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end

# Athentication:
gem 'cancan'

# Role and right management:
gem 'devise'

gem 'breadcrumbs_on_rails'
gem 'kaminari'
gem 'browser'


# Deploy with Capistrano
gem 'capistrano', '~> 3.1'
gem 'capistrano-rails', '~> 1.1'

gem 'bootstrap-sass'
gem 'jquery-ui-rails'

# Use Apache with PhusionPassenger
gem 'passenger', :group => [:staging, :production]

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
