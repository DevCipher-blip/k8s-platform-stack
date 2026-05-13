# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :description, :price, :title, :upc, :weight, :weight_unit
end
