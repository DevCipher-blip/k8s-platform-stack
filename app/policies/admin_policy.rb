# frozen_string_literal: true

class AdminPolicy < CustomerPolicy
  attr_reader :user, :record

  def initialize(user, record)
    super

    @user = user
    @record = record
  end
end
