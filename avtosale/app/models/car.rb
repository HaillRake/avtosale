# frozen_string_literal: true

class Car < ApplicationRecord
  TEXT_REGEX = /\A[a-zA-Z]+\z/
  paginates_per 3
  validates :date_added, presence: true
  validates :price, :odometer, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :year, numericality: { only_integer: true, greater_than: 1900, less_than_or_equal_to: Time.zone.now.year }
  validates :make, :model, length: { minimum: 3, maximum: 50 },
                           format: { with: TEXT_REGEX, message: I18n.t('make_model_error') }
end
