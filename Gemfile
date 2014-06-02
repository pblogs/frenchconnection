source 'https://rubygems.org'

ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'
gem 'quiet_assets'
gem 'pg'
gem 'rails_12factor'   # Needed for Rails4 on Heroku
gem 'newrelic_rpm'
gem 'foreman'

gem 'database_cleaner'
gem 'axlsx', '~> 2.0.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'
gem 'slim'
gem 'slim-rails'
gem 'font-awesome-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-sass-rails'


# Turbolinks makes following links in your web application faster. 
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
#

gem 'fabrication'
gem 'faker'

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :development do
  gem 'ruby_gntp'
  gem 'rails-footnotes', '>= 4.0.0', '<5'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'
end
  

gem 'neat'
gem 'bourbon'
gem 'bitters'

gem 'spreadsheet', '~> 0.9.7'

group :production do
  gem 'exception_notification'
end

