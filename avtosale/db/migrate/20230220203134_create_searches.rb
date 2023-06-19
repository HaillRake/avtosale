# frozen_string_literal: true

class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.string :make
      t.string :model
      t.integer :year_from
      t.integer :year_to
      t.string :ptice_from
      t.string :price_to

      t.timestamps
    end
  end
end
