source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'ahoy_matey'
gem 'rack-cors'
gem 'rails', '~> 6.1.0'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'exception_notification', "~> 4.5.0"
gem 'kaminari-mongoid',  '~> 1.0.1'

gem 'mongoid',           '~> 7.3.0'
gem 'mongoid_paranoia',  '~> 0.6.0'
gem 'mongoid-autoinc',   '~> 6.0.3'
gem 'mongoid-paperclip', '~> 0.1.0'
gem 'psych', '< 4'

gem 'devise',                         "~> 4.9.3"
gem "omniauth-keycloak",              "~> 1.5.1"
gem "omniauth-rails_csrf_protection", "~> 1.0.1"
gem 'ed25519', '~> 1.3.0'
gem 'bcrypt_pbkdf', '~> 1.1.0'
gem 'ffi', '~> 1.16.3'

gem 'wco_models',   github: 'wasya-co/wco_models',     branch: '3.2.0'
gem 'wco_hosting',  github: 'wasya-co/wco_hosting_rb', branch: '0.0.0'
gem 'wco_email',    github: 'wasya-co/wco_email_rb',   branch: '0.0.0'
gem 'iron_warbler', github: 'wasya-co/iron_warbler',   branch: '2.3.0'

group :development, :test do
  gem 'byebug'
  gem 'irb', '>= 1.2.8'
  gem 'net-ssh', "~> 7.2.0"
  gem 'rspec-rails'
end

group :development do
  gem 'capistrano'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'web-console',        '>= 4.1.0'
end

