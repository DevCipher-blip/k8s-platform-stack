# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_quantity, :product_price, presence: true, numericality: { greater_than: 0 }

  # The unit price is fixed from the catalogue when the item is created, so a
  # client cannot submit its own price.
  before_validation :copy_product_price, on: :create

  def subtotal
    product_quantity.to_i * product_price.to_d
  end

  private

    def copy_product_price
      self.product_price = product&.price
    end
end
