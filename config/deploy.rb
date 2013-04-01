require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, 'app'

set :scm, :git
set :repository, 'https://github.com/rubyonrails3/deploy-unicorn'
set :branch, :master

server '66.228.51.151', :web, :app, :db, :primary => true

set :user, 'deploy'
set :deploy_to, "/home/#{user}/#{application}"
set :use_sudo, false

set :deploy_via, :remote_cache

set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true


namespace :deploy do

  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, :roles => :app, :except => { :no_release => true } do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, :roles => :app do
    run "#{sudo} ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  end


end
