server 'SERVER_IP_ADDRESS', port: 22, roles: [:web, :app, :db], primary: true
set :repo_url,        'GIT_REPO_URL'
set :application,     'YOUR_APP_NAME'
set :user,            'DEPLOY_USER'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/YOUR_PRIVATE_KEY) }

set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"

set :stage, :production
set :branch, "develop"