# frozen_string_literal: true

class Product < ApplicationRecord
  ALLOWED_WEIGHT_UNITS = { g: 'g', kg: 'kg', lb: 'lb', oz: 'oz' }.freeze

  has_many :line_items, dependent: :destroy

  validates :title, :description, :price, presence: true
  validates :upc, uniqueness: true
  validates :price, numericality: { greater_than: 0.0 }
  validates :weight, numericality: { greater_than: 0.0 }, if: -> { weight.present? }
  validates :weight_unit, presence: true, if: -> { weight.present? }
  validates :weight_unit, inclusion: { in: ALLOWED_WEIGHT_UNITS.values }, if: -> { weight_unit.present? }

  before_save :prevent_upc_change
  before_destroy :validate_deletion, prepend: true

  private

    def prevent_upc_change
      return if new_record?

      errors.add(:upc, I18n.t('product.errors.upc.read_only'))

      raise ActiveRecord::RecordInvalid
    end

    def validate_deletion
      return if line_items.blank?

      errors.add(:base, I18n.t('product.errors.deletion'))

      throw :abort
    end
end
