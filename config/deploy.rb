# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'optolead'
set :repo_url, 'git@github.com:websumy/optolead.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml .env}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

desc 'Invoke a rake command on the remote server'
task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
  on primary(:app) do
    within current_path do
      with :rails_env => fetch(:rails_env) do
        rake args[:command]
      end
    end
  end
end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:reload'
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  after :publishing, :restart
  after :finishing, :cleanup
  before :finishing, :restart
  after :rollback, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end

namespace :rails do
  desc 'Open the rails console on each of the remote servers'
  task console: 'rvm:hook' do
    on roles(:app), primary: true do |host|
      execute_interactively host, 'console production'
    end
  end
end

def execute_interactively(host, command)
  command = "cd #{fetch(:deploy_to)}/current && #{SSHKit.config.command_map[:bundle]} exec rails #{command}"
  puts command if fetch(:log_level) == :debug
  exec "ssh -l #{host.user} #{host.hostname} -p #{host.port || 22} -t '#{command}'"
end
