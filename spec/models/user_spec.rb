require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'Presence validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:phone) }
    end

    context 'Admin password validations' do
      subject { FactoryBot.build(:user, :admin) }

      it { should validate_presence_of(:password).on(:create) }
      it { should validate_presence_of(:password_confirmation).on(:create) }
    end

    context 'Customer invited without a password' do
      it 'is valid on create so the welcome email can ask them to set one' do
        customer = FactoryBot.build(:user, :customer, password: nil, password_confirmation: nil)

        expect(customer).to be_valid
      end
    end

    context 'Format validations' do
      it { should allow_value('example@domain.com').for(:email) }
      it { should_not allow_value('example').for(:email) }
    end
  end
end
