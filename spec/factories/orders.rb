FactoryBot.define do
  factory :order do
    customer
    sequence(:number) { |n| 1000 + n }
    date { Date.current }
    payment_type { 'cash' }

    after(:build) do |order|
      order.shipping_address ||= FactoryBot.build(:shipping_address, addressable: order)
      order.line_items << FactoryBot.build(:line_item, order: order) if order.line_items.empty?
    end
  end

  factory :line_item do
    product
    product_quantity { 2 }
    product_price { product.price }
  end
end
