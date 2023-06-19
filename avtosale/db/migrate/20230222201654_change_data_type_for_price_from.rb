# frozen_string_literal: true

class ChangeDataTypeForPriceFrom < ActiveRecord::Migration[7.0]
  def change
    change_column :searches, :price_from, :integer
  end
end
