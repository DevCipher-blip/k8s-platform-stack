# frozen_string_literal: true

class CustomerPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    user.admin? || user.id == record.id
  end

  def update?
    user.admin? || user.id == record.id
  end

  def destroy?
    user.admin? || user.id == record.id
  end
end
