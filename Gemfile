source 'https://rubygems.org'
ruby '2.1.0'
gem 'rails', '3.2.14'

gem 'heroku'
gem 'american_date'
# # gem 'bootstrap-datepicker-rails'
# gem 'bootstrap-datepicker-rails'
# gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails',
                              # :git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'
# gem 'activerecord-mysql2-adapter'
gem 'will_paginate', '~> 3.0.5'
gem 'pundit'
# gem 'rvm-capistrano',  require: false
group :production do
   gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem  'mysql2', '~>0.3.10'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
  gem 'execjs'
end


gem 'jquery-rails', '~> 2.2.1'
gem 'bootstrap-sass', '~> 2.3.2.2'
# gem 'twitter-bootstrap-rails'
gem 'devise'
gem 'simple_form'
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'

group :development do
  gem 'better_errors'
  gem 'quiet_assets'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  #gem 'launchy'
end
