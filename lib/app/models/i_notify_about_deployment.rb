# INotifyAboutDeployment
require "action_mailer"
module INotifyAboutDeployment
  class Mailer < ActionMailer::Base

    #load custom mailer settings
    def self.load_settings()
      if RAILS_ENV != 'test'
        email_settings = YAML::load(File.open("#{RAILS_ROOT}/vendor/plugins/i_notify_about_deployment/config/email.yml"))
        Mailer.smtp_settings = email_settings[RAILS_ENV] unless email_settings[RAILS_ENV].nil?
        Mailer.template_root = "#{RAILS_ROOT}/vendor/plugins/i_notify_about_deployment/lib/app/views/"
      end
    end

    #send notification with some parameter
    def notification_about_deployment(to, project, sender = self.from, environment = "production", sent_on = Time.now.strftime("%c"), subject = "Deployed on #{sent_on}")
      subject    subject
      recipients to
      from       sender
      sent_on    sent_on
      body       :project => project, :environment => environment, :sent_on => sent_on
      content_type "text/plain"
    end
  end
end
