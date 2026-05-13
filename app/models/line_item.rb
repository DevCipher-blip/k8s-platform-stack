# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_quantity, :product_price, presence: true, numericality: { greater_than: 0 }
end
