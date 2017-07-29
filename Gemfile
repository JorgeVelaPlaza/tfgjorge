source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use postgresql as the database for Active Record
gem 'pg'
gem 'devise'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.2.1'
gem 'jquery-ui-rails', '~> 6.0.1'
gem 'jquery-turbolinks'

# Para instalar adminlte
gem 'bootstrap-sass'
gem 'font-awesome-sass'

source 'https://rails-assets.org/' do
  gem 'rails-assets-adminlte'
end

gem 'carrierwave'
gem 'redcarpet', '~> 3.4'
gem 'pygments.rb', '~> 1.1', '>= 1.1.1'
gem 'sprockets', '~> 3.7', '>= 3.7.1'
gem 'delayed_job_active_record'
gem 'daemons'


# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development do
  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-delayed-job', '~> 1.0'


  # Remove the following if your app does not use Rails
  gem 'capistrano-rails', '~> 1.2'

  # Remove the following if your server does not use RVM
  gem 'capistrano-rvm'
end
