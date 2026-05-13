# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer
  has_one :shipping_address, as: :addressable, class_name: 'ShippingAddress', dependent: :destroy
  has_many :line_items, dependent: :destroy

  validates :number, :date, :payment_type, :line_items, :shipping_address, presence: true
  validates :number, uniqueness: true, numericality: { greater_than: 0 }

  enum payment_type: { cash: 'cash', credit_card: 'credit_card', check: 'check', other: 'other' }

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :line_items

  after_create_commit :update_total_value

  private

    def update_total_value
      update!(total_value: line_items.sum(:product_price))
    end
end
