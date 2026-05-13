require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it 'takes its unit price from the product, not from the caller' do
    product = create(:product, price: 25)
    order = build(:order, line_items: [])
    order.line_items.build(product: product, product_quantity: 1, product_price: 0.01)

    order.save!

    expect(order.line_items.find_by(product: product).product_price).to eq(25)
  end
end
