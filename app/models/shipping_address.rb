# frozen_string_literal: true

class ShippingAddress < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :address_line, :city, :state, :zip_code, :country_code, presence: true
end
