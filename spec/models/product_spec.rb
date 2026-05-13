require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }

  it 'assigns a UPC from the database sequence' do
    expect(product.reload.upc).to be >= 1
  end

  it 'can be updated' do
    expect(product.update(price: 99)).to be(true)
  end

  it 'refuses to change its UPC' do
    product.upc += 1

    expect(product).not_to be_valid
    expect(product.errors[:upc]).to include('Cannot be changed')
  end

  it 'cannot be deleted once it has been ordered' do
    create(:order, line_items: [build(:line_item, product: product)])

    expect(product.destroy).to be(false)
  end
end
