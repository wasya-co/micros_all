lock "~> 3.18.0"

set :application, "micros_trading"
set :repo_url,    "git@github.com:wasya-co/micros_email.git"
set :branch,      ENV['BRANCH'] || 'trading-0.0.0'
set :deploy_via,  :remote_cache
set :deploy_to,   "/opt/projects/micros_trading"

append :linked_files, "log/production.log",
  "config/database.yml",
  "config/mongoid.yml",
  "config/initializers/00_s3.rb",
  # "config/initializers/05_stripe.rb",
  "config/initializers/08_integrations.rb",
  "config/initializers/action_mailer.rb",
  ".env"

namespace :deploy do
  task :bundle do
    on roles(:web) do
      execute "cd #{fetch(:deploy_to)}/current && . .env && /root/.rbenv/shims/bundle "
    end
  end
end

after "deploy:published", "bundle"