source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'ahoy_matey'
gem 'bcrypt', '~> 3.1.7'
gem 'devise',                         "~> 4.9.3"
gem 'exception_notification'
gem 'jbuilder', '~> 2.7'
gem 'kaminari-mongoid',  '~> 1.0.1'
gem 'kaminari-actionview'

gem 'psych', '~> 5.0.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.0'
gem 'sass-rails'

## can I require from wco_models instead?
# gem 'mongoid',           '~> 7.3.0'
# gem 'mongoid_paranoia',  '~> 0.6.0'
# gem 'mongoid-autoinc',   '~> 6.0.3'
# gem 'mongoid-paperclip', '~> 0.1.0'

gem 'nokogiri', '~> 1.15.5'
gem "omniauth-keycloak",              "~> 1.5.1"
gem "omniauth-rails_csrf_protection", "~> 1.0.1"
gem 'sidekiq'
gem 'ed25519', '~> 1.3.0'
gem 'bcrypt_pbkdf', '~> 1.1.0'
gem 'stringio', '3.1.2'
# gem 'rb-gsl'

gem 'wco_models', github: 'wasya-co/wco_models',   branch: '3.2.0'

group :development, :test do
  gem 'byebug'

  # gem 'capybara'

  # gem 'rspec-rails'

  # gem 'selenium-webdriver', "~> 4.9.0"

  ## From: https://stackoverflow.com/questions/24004728/getting-selenium-webdriver-to-use-chrome-in-rspec-rails
  # gem 'chromedriver-helper'

  gem 'irb', '>= 1.2.8'
end

group :development do
  gem 'capistrano'

  ## https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'

  gem 'web-console', '>= 4.1.0'
end

