# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  # `record` is the Customer whose orders are being listed.
  def index?
    admin? || user.id == record.id
  end

  # A customer may only place orders for themselves; admins may place them
  # for anyone.
  def create?
    admin? || (user.customer? && user.id == record.customer_id)
  end

  def show?
    admin? || user.id == record.customer_id
  end

  def destroy?
    show?
  end
end
