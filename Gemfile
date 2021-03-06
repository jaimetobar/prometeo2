source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.1.4'

### OpenShift Online changes:

# Fix the conflict with the system 'rake':
gem 'rake', '~> 0.9.6'

# Support for databases and environment.
# Use 'sqlite3' for testing and development and mysql and postgresql
# for production.
#
# To speed up the 'git push' process you can exclude gems from bundle install:
# For example, if you use rails + mysql, you can:
#
# $ rhc env set BUNDLE_WITHOUT="development test postgresql"
#
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

group :development do
  gem 'spring'
  gem 'annotate'
  gem 'letter_opener'
end
group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'byebug'
  gem 'thor'
  gem 'faker'
  gem 'figaro'
end
group :test do
  gem 'database_cleaner'
  # OSX install before
  # brew install qt
  gem 'capybara-webkit','~> 1.5.2'
end

gem 'pg'


### / OpenShift changes

# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

gem 'devise'
gem 'table_print'
gem 'time_difference'
gem 'nested_form_fields'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.7.14'
gem 'email_validator'
gem 'rails-i18n', '~> 4.0.0'
gem 'country_select'
gem 'will_paginate'
gem 'sidekiq'
gem 'devise-async'
gem 'devise-i18n'
gem 'sinatra', :require => false
gem 'globalize', '~> 4.0.3'
gem 'config'
gem 'font-awesome-rails'
#windows specific
gem 'tzinfo-data', platforms: [:mingw, :mswin]
#slider
gem 'bxslider-rails'
gem 'roo', '~> 2.3.2'
gem 'roo-xls'
gem 'haml-rails', '~> 0.9'
