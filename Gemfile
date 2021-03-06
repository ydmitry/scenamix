source 'https://rubygems.org'

gem 'rails', '~> 4.0.0'

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
  gem 'coffee-rails', :github => 'rails/coffee-rails'
  gem 'uglifier'
end

# for Heroku deployment - as described in Ap. A of ELLS book
group :development, :test do
  gem 'sqlite3'
  gem 'cucumber-rails-training-wheels'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails', '~> 2.0'
  gem 'jasmine', '~> 1.2.1'
end

group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'simplecov'
  gem 'factory_girl_rails', '~> 4.0'
end


group :production do
  gem 'pg'
end

gem 'underscore-rails'
gem 'jquery-rails'
gem 'backbone-on-rails'
gem 'requirejs-rails', :github => 'jwhitley/requirejs-rails'

gem 'haml-rails', :github => 'indirect/haml-rails'

gem 'devise', github: 'plataformatec/devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'twitter'
gem 'fb_graph'

gem 'active_model_serializers', :github => 'rails-api/active_model_serializers'
