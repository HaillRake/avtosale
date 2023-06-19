# frozen_string_literal: true

class ChangeDataTypeForPriceTo < ActiveRecord::Migration[7.0]
  def change
    change_column :searches, :price_to, :integer
  end
end
