class ApplicationMailer < ActionMailer::Base
  default from: -> { ENV.fetch('SENDER_EMAIL', 'support@example.com') }

  layout 'mailer'
end
