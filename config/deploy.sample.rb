set :application, "dlist"

set :scm, :git
set :repository,  "git@github.com:funtaff/loni-dlist.git"
set :branch, "master"

set :deploy_to, "/home/user/apps/#{application}-production"
set :deploy_via, :remote_cache

set :use_sudo, false

set :user, "username"
set :runner, "username"

role :app, "dlist.yourdomain.com"
role :web, "dlist.yourdomain.com"
role :db,  "dlist.yourdomain.com", :primary => true

namespace :deploy do
  desc 'Restarting the application'
  task :restart do
    puts 'Restarting the application'
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'