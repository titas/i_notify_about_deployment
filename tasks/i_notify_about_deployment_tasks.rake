# desc "Explaining what the task does"
namespace :i_notify_about_deployment do

  require "rubygems"
  require "action_mailer"

  desc "Sends email notification to plugin_root/config/i_notify_about_deployment.yml:to about deployment. Uses aditional params from that YAML file"
  task :notify do
    puts "Environment: #{ENV['ENV']}" if ENV['ENV']
    puts "Revision: #{ENV['REVISION']}" if ENV['REVISION']
    puts "User: #{ENV['USER']}" if ENV['USER']
    if RUBY_VERSION.gsub(".", "").to_i <= 186
      require "#{RAILS_ROOT}/vendor/plugins/action_mailer_optional_tls/lib/action_mailer_tls.rb"
      require "#{RAILS_ROOT}/vendor/plugins/action_mailer_optional_tls/lib/smtp_tls.rb"
    end
    require "#{RAILS_ROOT}/vendor/plugins/i_notify_about_deployment/lib/app/models/i_notify_about_deployment.rb"
    INotifyAboutDeployment::Mailer.load_settings(ENV['ENV'])
    config = YAML::load(File.open("#{RAILS_ROOT}/vendor/plugins/i_notify_about_deployment/config/i_notify_about_deployment_settings.yml"))
    if !config.has_key?("to")
      puts "No recipient in \"RAILS_ROOT/Vendor/plugins/i_notify_about_deployment/config/i_notify_about_deployment_settings.ymll\"," +
           "can not notify. Please add \"to: my.redmine@email.com\" to the yml file."
      puts "Rake unsuccessful"
    elsif !config.has_key?("project")
      puts "No project identifier in \"RAILS_ROOT/vendor/plugins/i_notify_about_deployment/config/i_notify_about_deployment_settings.yml\"," +
           "can not notify. Please add \"project: identifier\" to the yml file."
      puts "Rake unsuccessful"
    else
      ret = INotifyAboutDeployment::Mailer.deliver_notification_about_deployment(config["to"], 
        config["project"], ENV['ENV'], ENV['REVISION'], ENV['USER'], config["from"])
      ret ? (puts "Rake successful") : (puts "Rake unsuccessful")
    end
  end
  
end
