require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'Presence validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:phone) }
      it { should validate_presence_of(:password).on(:create) }
      it { should validate_presence_of(:password_confirmation).on(:create) }
    end

    context 'Format validations' do
      it { should allow_value('example@domain.com').for(:email) }
      it { should_not allow_value('example').for(:email) }
    end
  end
end
