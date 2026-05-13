require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  describe 'associations' do
    it { should belong_to(:addressable) }
  end

  describe 'validations' do
    context 'Presence validations' do
      it { should validate_presence_of(:address_line) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:state) }
      it { should validate_presence_of(:zip_code) }
      it { should validate_presence_of(:country_code) }
    end
  end
end
