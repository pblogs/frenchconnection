source 'https://rubygems.org'

ruby '2.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x
gem 'rails_12factor', group: :production
gem 'ng-rails-csrf'
gem 'pg'
gem 'symbolize'
gem 'sidekiq'
gem 'lightbox2-rails'
gem 'pundit'
gem 'react-rails', '~> 1.0', github: 'reactjs/react-rails'

gem 'activeadmin', github: 'activeadmin'
gem 'browserify-rails'


gem 'tinymce-rails', '4.1.6'
gem 'tinymce-rails-imageupload', '~> 4.0.0.beta'
gem 'html_truncator', '0.4.0'

# API
gem 'grape', github: 'intridea/grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'grape-rails-cache'


gem 'devise'

gem 'axlsx', '~> 2.0.1'
gem 'alphabetical_paginate'



# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'
gem 'slim'
gem 'slim-rails'
gem 'font-awesome-rails'
gem 'bower-rails'
gem 'neat'
gem 'bourbon'
gem 'bitters'
gem 'refills'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'



# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end


gem 'fabrication'
gem 'faker'

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec', require: false
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'pry'
end

group :development do
  gem 'annotate'
  gem 'ruby_gntp'
  gem 'rails-footnotes', '>= 4.0.0', '<5'
  gem 'better_errors'
  gem 'quiet_assets'
end


group :test do
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver', '>= 2.44.0'
end



group :development, :production do
  gem 'foreman'
  gem 'thor'
  gem 'pusher'
  #gem 'ransack', github: 'activerecord-hackery/ransack'
  gem 'ransack'
end

group :production do
  gem 'passenger'
  gem 'carrierwave'
  gem 'mini_magick'
  gem 'wkhtmltopdf-binary'
  gem 'fog'
  gem 'exception_notification'
  gem 'roo' # Used for the Excel import
  gem 'wkhtmltopdf-heroku', github: 'cater2me/wkhtmltopdf-heroku'
  gem 'newrelic_rpm'
  gem 'iconv'
  gem 'pdfkit'
end

gem 'rest-client'

gem 'dalli'
gem 'memcachier'

group :development do
  gem 'growl'
end

gem 'lodash-rails'
gem 'angularjs-rails'
gem 'angular_rails_csrf'
gem 'rack-cors',
  :require => 'rack/cors'
