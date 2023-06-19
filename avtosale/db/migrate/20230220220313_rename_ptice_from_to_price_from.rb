# frozen_string_literal: true

class RenamePticeFromToPriceFrom < ActiveRecord::Migration[7.0]
  def change
    rename_column :searches, :ptice_from, :price_from
  end
end
