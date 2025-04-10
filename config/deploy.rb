lock "~> 3.19.1"

set :application, "micros_trading"
set :repo_url,    "git@github.com:wasya-co/micros_email.git"
set :branch,      ENV['BRANCH'] || 'trading-0.0.0'
set :deploy_via,  :remote_cache
set :deploy_to,   "/opt/projects/micros_trading"

append :linked_files, "log/production.log",
  "config/master.key",
  "config/mongoid.yml",
  "config/initializers/00_s3.rb",
  # "config/initializers/05_stripe.rb",
  "config/initializers/08_integrations.rb",
  "config/initializers/action_mailer.rb",
  ".bundle/config"

namespace :deploy do
  task :bundle do
    on roles(:web) do
      execute "cd #{fetch(:deploy_to)}/current && /root/.rbenv/shims/bundle && RAILS_ENV=production /root/.rbenv/shims/bundle exec rake assets:precompile"
    end
  end

  task :create_indexes do
    on roles(:web) do
      execute "cd #{fetch(:deploy_to)}/current && RAILS_ENV=production /root/.rbenv/shims/bundle exec rake db:mongoid:create_indexes "
    end
  end

  task :fix_cache do
    on roles(:web) do
      execute "cd #{fetch(:deploy_to)}/current && chmod a+w tmp/cache"
    end
  end

  task :restart_services do
    on roles(:web) do
      execute "nginx -s reload"
      # execute "service iro_alerts restart"
      execute "service wco_email_sidekiq restart"
      execute "service wco_email_send_contexts restart"
      execute "service wco_email_run_email_actions restart"
      execute "service wco_run_office_actions restart"
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
after "deploy:published", "fix_cache"
after "deploy:published", "restart_services"
