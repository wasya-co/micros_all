
= Micros Hosting =

When assembled, it provides a system for administering one-click, turn-key app installs.

== Repositories ==

<pre>
micros_all.git/hosting-x.x.x
  wco_hosting.git
wasya_co_rb.git/x.x.x
</pre>

= Install =

In .bashrc:

  alias ll='ls -lah '
  alias dc='docker-compose ' ## or depending on the version: alias dc='docker compose '

Run in this directory:

  cp _env .env
  cp config/initializers/00_s3.rb-example config/initializers/00_s3.rb

Run in ruby interpreter:

  p = Wco::Profile.create({ email: 'victor@piousbox.com' })

Run docker services:

  dc up -d localstack_development
  dc up -d mongo_development

From: https://docs.localstack.cloud/getting-started/quickstart/
Run in localstack ( First `./scripts/login_mac localstack_d` then ):

  awslocal s3 mb s3://micros-hosting-development
  awslocal s3 mb s3://micros-hosting-test


= Develop =

=== keycloak ===

* 2023-12-15
* https://github.com/ccrockett/omniauth-keycloak?tab=readme-ov-file
** https://github.com/omniauth/omniauth
