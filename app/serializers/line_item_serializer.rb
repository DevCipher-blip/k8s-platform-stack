# frozen_string_literal: true

class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :product_quantity, :product_price

  # An attribute rather than belongs_to: AMS renders associations only one
  # level deep, and the product must appear under order -> line_items.
  attribute :product do
    ProductSerializer.new(object.product).attributes
  end
end
