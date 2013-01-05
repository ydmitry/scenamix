source 'https://rubygems.org'

gem 'rails', '3.2.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'

gem 'libv8', '~> 3.11.8'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'
  gem 'less-rails'
  gem 'twitter-bootstrap-rails', '~> 2'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier'
end

# for Heroku deployment - as described in Ap. A of ELLS book
group :development, :test do
  gem 'sqlite3'
  gem 'cucumber-rails-training-wheels'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails', "~> 2.0"
  gem 'simplecov'
end

group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
end


group :production do
  gem 'pg'
end



# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'jquery-rails'
gem 'haml-rails', '= 0.3.4'
gem 'devise'
gem 'backbone-on-rails'
gem 'requirejs-rails'
