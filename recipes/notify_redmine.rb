after "deploy",            "i_notify_about_deployment:notify_redmine"
after "deploy:migrations", "i_notify_about_deployment:notify_redmine"

namespace :i_notify_about_deployment do
  desc "Notify Redmine of the deployment"
  task :notify_redmine do
    rails_env = fetch(:rails_env, "production")
    local_user = ENV['USER'] || ENV['USERNAME']
    notify_command = "rake i_notify_about_deployment:notify ENV=#{rails_env} REVISION=#{current_revision} USER=#{local_user}"
    puts `#{notify_command}`
  end
end
