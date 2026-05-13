# frozen_string_literal: true

class CustomerMailer < ApplicationMailer
  def welcome_customer(recipient_name, recipient_email)
    @customer_name = recipient_name

    mail(to: recipient_email, subject: I18n.t('customer.notifications.email.subject'))
  end
end
