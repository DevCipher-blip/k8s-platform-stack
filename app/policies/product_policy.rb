# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  # The catalogue is public.
  def index?
    true
  end

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end
end
