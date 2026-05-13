require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) { build(:order) }

  it { should validate_uniqueness_of(:number) }

  it 'totals quantity times unit price across line items' do
    kettle = create(:product, price: 39.9)
    mug = create(:product, price: 6.5)
    order = build(:order, line_items: [build(:line_item, product: kettle, product_quantity: 2),
                                       build(:line_item, product: mug, product_quantity: 3)])

    order.save!

    expect(order.reload.total_value).to eq(BigDecimal('99.3'))
  end

  it 'rejects an unknown payment type with a validation error' do
    order.payment_type = 'barter'

    expect(order).not_to be_valid
    expect(order.errors[:payment_type]).to be_present
  end
end
