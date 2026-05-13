# frozen_string_literal: true

class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :product_quantity, :product_price, :product

  def product
    ActiveModelSerializers::SerializableResource.new(object.product)
  end
end
