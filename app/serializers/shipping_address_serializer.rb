# frozen_string_literal: true

class ShippingAddressSerializer < ActiveModel::Serializer
  attributes :id, :address_line, :city, :state, :zip_code, :country_code, :addressable_type
end
