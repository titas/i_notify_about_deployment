# INotifyAboutDeployment
require "action_mailer"
module INotifyAboutDeployment
  class Mailer < ActionMailer::Base

    #load custom mailer settings
    def self.load_settings(env)
      if env != 'test'
        email_settings = YAML::load(File.open("#{RAILS_ROOT}/vendor/plugins/i_notify_about_deployment/config/email.yml"))
        Mailer.smtp_settings = email_settings[env] unless email_settings[env].nil?
        Mailer.template_root = "#{RAILS_ROOT}/vendor/plugins/i_notify_about_deployment/lib/app/views/"
      end
    end

    #send notification with some parameter
    def notification_about_deployment(to, project, environment, revision, user, from = self.from, sent_on = Time.now, subject = "New version deployed on #{sent_on.strftime('%c')} by #{user}")
      subject    subject
      recipients to
      from       from
      sent_on    sent_on
      body       :project => project, :environment => environment, :sent_on => sent_on, :revision => revision, :user => user
      content_type "text/plain"
    end
  end
end
