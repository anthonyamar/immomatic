source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# STYLE
gem 'bootstrap', '~> 4.1.3'
gem 'sassc-rails'
gem 'bootstrap-will_paginate'

# API
gem 'rest-client'

# FORMS
gem 'simple_form'
gem 'virtus'

# ACTIVE RECORDS 
gem 'by_star'
gem 'groupdate'

# USERS
gem 'devise'
gem 'devise-i18n'

# ENV
gem 'figaro', '~> 1.1.1'

# JS
gem 'jquery-rails'

# RAILS MANDATORY
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'
gem 'uglifier', '>= 1.3.0'
gem 'draper'

# ASYNC
gem 'sidekiq', '~> 5.2.2'

# EXTERNAL SERVICES
#gem 'bootsnap', '>= 1.1.0', require: false

# SEEDS
gem 'faker', '~> 1.9', '>= 1.9.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop', '~> 0.59.2', require: false
	gem 'pry'
  gem 'pry-byebug'
end

group :development do
  gem "better_errors"
  gem 'guard-rspec', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
	gem 'letter_opener'
end

group :test do
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
  gem 'rspec-rails', '~> 3.8'
  gem "rspec_junit_formatter", '~> 0.4', '>= 0.4.1'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end