# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer
  has_one :shipping_address, as: :addressable, class_name: 'ShippingAddress', dependent: :destroy
  has_many :line_items, dependent: :destroy

  validates :number, :date, :payment_type, :line_items, :shipping_address, presence: true
  validates :number, uniqueness: true, numericality: { greater_than: 0 }

  # validate: true turns an unknown payment type into a 422 instead of an ArgumentError.
  enum :payment_type, { cash: 'cash', credit_card: 'credit_card', check: 'check', other: 'other' }, validate: true

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :line_items

  before_save :assign_total_value

  private

    # Runs after validation, when each new line item has already copied its
    # unit price from the product.
    def assign_total_value
      self.total_value = line_items.reject(&:marked_for_destruction?).sum(&:subtotal)
    end
end
