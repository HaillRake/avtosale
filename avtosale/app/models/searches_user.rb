# frozen_string_literal: true

class SearchesUser < ApplicationRecord
  belongs_to :search
  belongs_to :user

  scope :with_params, lambda { |params|
                        where(search_id: params[:search_id],
                              user_id: params[:user_id])
                      }
end
