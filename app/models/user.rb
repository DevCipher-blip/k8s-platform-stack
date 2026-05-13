# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  include DeviseTokenAuth::Concerns::User

  validates :name, :email, :phone, presence: true
  validates :password, :password_confirmation, presence: true, on: :create, if: :admin?
  validates :password, :password_confirmation, presence: true, on: :update, if: -> { encrypted_password.blank? }
  validates :email, format: { with: Devise.email_regexp }

  def admin?
    type == Admin.name
  end

  def customer?
    type == Customer.name
  end

  # Adds a custom attribute to the successful sign_in response
  def as_json(options = {})
    super(options).merge({ type: type })
  end
end
