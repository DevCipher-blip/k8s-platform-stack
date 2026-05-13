# frozen_string_literal: true

class Customer < User
  has_one :shipping_address, as: :addressable, class_name: 'ShippingAddress', dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :email, :phone, uniqueness: true

  after_create_commit :send_welcome_email, if: -> { encrypted_password.blank? }
  before_destroy :validate_deletion, prepend: true

  private

    def send_welcome_email
      CustomerMailer.welcome_customer(name, email).deliver!
    end

    def validate_deletion
      return if orders.blank?

      errors.add(:base, I18n.t('customer.errors.deletion'))

      throw :abort
    end
end
