# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :date, :payment_type, :total_value

  belongs_to :customer
  has_one :shipping_address
  has_many :line_items
end
