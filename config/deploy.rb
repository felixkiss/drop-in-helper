require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

server "198.211.124.77", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "drop-in-helper"
set :server_name, "drop-in.fkiss.info"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:felixkiss/#{application}.git"
set :branch, "master"

# set :ssl_certificate, "recipes/certs/#{application}.crt"
set :ssl_certificate, File.expand_path("../recipes/certs/#{application}.crt", __FILE__)
# set :ssl_certificate_key, "recipes/certs/#{application}.key"
set :ssl_certificate_key, File.expand_path("../recipes/certs/#{application}.key", __FILE__)

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases