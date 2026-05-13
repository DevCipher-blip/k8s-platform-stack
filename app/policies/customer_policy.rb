# frozen_string_literal: true

class CustomerPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def create?
    admin?
  end

  def show?
    admin? || user.id == record.id
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
