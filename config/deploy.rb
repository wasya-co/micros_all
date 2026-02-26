lock "~> 3.18.0"

set :application, "micros_content"
set :repo_url,    "git@github.com:wasya-co/micros_all.git"
set :branch,      ENV['BRANCH'] || 'content-0.1.0'
set :deploy_via,  :remote_cache
set :deploy_to,   "/opt/projects/micros_content"

append :linked_files, ".bundle/config", # github key
  "config/credentials.yml.enc",
  "config/initializers/00_s3.rb",
  "config/initializers/05_stripe.rb",
  "config/initializers/08_integrations.rb",
  "config/initializers/09_action_mailer.rb",
  "config/master.key",
  "config/mongoid.yml",

  "log/production.log",

namespace :deploy do
  task :bundle do
    on roles(:web) do
      execute "cd #{fetch(:deploy_to)}/current && /root/.rbenv/shims/bundle && RAILS_ENV=production /root/.rbenv/shims/bundle exec rake assets:precompile"
      execute "nginx -s reload"
    end
  end

  task :create_indexes do
    on roles(:web) do
      execute "cd #{fetch(:deploy_to)}/current && RAILS_ENV=production /root/.rbenv/shims/bundle exec rake db:mongoid:create_indexes "
    end
  end
end

after "deploy:published", "bundle"
after "deploy:published", "create_indexes"
