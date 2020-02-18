require 'dotenv'

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
set :linked_files, %w{.env config/master.key}
append :linked_dirs, '.bundle'

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

before "deploy:assets:precompile", "deploy:yarn_install"

namespace :deploy do
  # Trigger the task before publishing
  before 'deploy:publishing', 'db:seed_fu'

  desc 'Run rake yarn:install'
  task :yarn_install do
    on roles(:app) do
      within release_path do
        execute("cd #{release_path} && yarn install")
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end

namespace :db do
  desc 'Resets DB without create/drop'
  task :reset do
    on primary :db do
      within release_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
        end
      end
    end
  end
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
