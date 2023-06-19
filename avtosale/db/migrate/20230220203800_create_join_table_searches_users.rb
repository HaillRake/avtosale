# frozen_string_literal: true

class CreateJoinTableSearchesUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :searches, :users do |t|
      t.index %i[search_id user_id]
      t.index %i[user_id search_id]
    end
  end
end
