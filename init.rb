require "#{RAILS_ROOT}/vendor/plugins/i_notify_about_deployment/lib/app/models/i_notify_about_deployment"
if RUBY_VERSION.gsub(".", "").to_i <= 186
  require "#{RAILS_ROOT}/vendor/plugins/action_mailer_optional_tls/lib/action_mailer_tls.rb"
  require "#{RAILS_ROOT}/vendor/plugins/action_mailer_optional_tls/lib/smtp_tls.rb"
end