# frozen_string_literal: true

class Search < ApplicationRecord
  has_many :searches_users, dependent: :delete_all
  has_many :users, through: :searches_users

  validates :year_from, :year_to, :price_from, :price_to, numericality: { only_integer: true, allow_nil: true }

  scope :with_params, lambda { |params|
                        where(make: params[:make].downcase,
                              model: params[:model].downcase,
                              year_from: params[:year_from].presence,
                              year_to: params[:year_to].presence,
                              price_from: params[:price_from].presence,
                              price_to: params[:price_to].presence)
                      }

  def self.normalize_params(params)
    normalized_params = params.dup
    normalized_params[:make] = normalized_params[:make].downcase if normalized_params[:make].present?
    normalized_params[:model] = normalized_params[:model].downcase if normalized_params[:model].present?
    normalized_params
  end
end
