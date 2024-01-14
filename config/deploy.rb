lock "~> 3.18.0"

set :application, "micros_email"
set :repo_url,    "git@github.com:wasya-co/micros_email.git"
set :branch,      ENV['BRANCH'] || 'email-0.0.1'
set :deploy_via,  :remote_cache
set :deploy_to,   "/opt/projects/micros_email"

append :linked_files, "log/production.log",
  ".bundle/config", # github key
  "config/initializers/00_s3.rb",
  "config/initializers/05_stripe.rb",
  "config/initializers/08_integrations.rb",
  "config/initializers/09_action_mailer.rb",
  # "config/master.key",
  "config/mongoid.yml"

namespace :deploy do
  task :bundle do
    on roles(:web) do
      execute "cd #{fetch(:deploy_to)}/current && /root/.rbenv/shims/bundle && RAILS_ENV=production /root/.rbenv/shims/bundle exec rake assets:precompile"
    end
  end

  task :restart_services do
    on roles(:web) do
      execute "nginx -s reload"
      # execute "service wco_email_sidekiq restart"
      # execute "service wco_email_send_contexts restart"
      # execute "service wco_email_run_email_actions restart"
      # execute "service wco_email_churn_stubs restart"
    end
  end
end

after "deploy:published", "bundle"
after "deploy:published", "restart_services"
