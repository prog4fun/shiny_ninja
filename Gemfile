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
  
group :development, :test do  
  gem 'puma'
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print'
  gem 'rspec-rails', '~> 3.0.2' # Update! (https://rubygems.org/gems/rspec-rails, https://github.com/rspec/rspec-rails)
  gem 'factory_girl_rails'
  gem 'fuubar' #, '~> 2.0.0.rc1'
end
 
group :test do
  gem 'capybara'
  gem 'email_spec'
  gem 'faker'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
end

# Athentication:
gem 'cancan'

# Role and right management:
gem 'devise'

gem 'breadcrumbs_on_rails'
gem 'kaminari'
gem 'browser'


# Deploy with Capistrano
group :development do
  gem 'capistrano',  '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
end

gem 'bootstrap-sass'
gem 'jquery-ui-rails'

# NewRelic
gem 'newrelic_rpm'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
