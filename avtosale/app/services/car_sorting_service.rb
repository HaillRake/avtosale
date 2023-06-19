# frozen_string_literal: true

class CarSortingService < BaseService
  SORT_OPTIONS = {
    'date_added_desc' => { date_added: :desc },
    'date_added_asc' => { date_added: :asc },
    'price_desc' => { price: :desc },
    'price_asc' => { price: :asc }
  }.freeze

  def initialize(cars, sort_by = nil)
    @cars = cars
    @sort_by = sort_by
  end

  def call
    @cars.order(**SORT_OPTIONS[@sort_by])
  end
end
