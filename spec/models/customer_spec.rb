require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { should have_one(:shipping_address).class_name(ShippingAddress.name).dependent(:destroy) }
  end

  describe 'validations' do
    let!(:customer) { FactoryBot.create(:user, :customer) }

    context 'Uniqueness validations' do
      let(:customer_with_unique_fields) { FactoryBot.create(:user, :customer) }

      it 'should ensure that email is unique' do
        expect(customer.email).not_to be_equal(customer_with_unique_fields.email)
      end

      it 'should ensure that phone is unique' do
        expect(customer.phone).not_to be_equal(customer_with_unique_fields.phone)
      end
    end
  end
end
