# frozen_string_literal: true

class SearchService < BaseService
  def initialize(params)
    @params = params
  end

  def call
    query = Car.all
    query = search_by_make(query) if @params[:make].present?
    query = search_by_model(query) if @params[:model].present?
    query = search_by_year_price(query) if [@params[:year_from], @params[:year_to], @params[:price_from],
                                            @params[:price_to]].any?(&:present?)
    query
  end

  private

  def search_by_make(query)
    query.where('lower(make) = ?', @params[:make].downcase)
  end

  def search_by_model(query)
    query.where('lower(model) = ?', @params[:model].downcase)
  end

  def search_by_year_price(query)
    query = search_by_year(query) if @params[:year_from].present? || @params[:year_to].present?
    query = search_by_price(query) if @params[:price_from].present? || @params[:price_to].present?
    query
  end

  def search_by_year(query)
    if @params[:year_from].present? && @params[:year_to].present?
      query.where(year: @params[:year_from]..@params[:year_to])
    elsif @params[:year_from].present?
      query.where('year >= ?', @params[:year_from])
    else
      query.where('year <= ?', @params[:year_to])
    end
  end

  def search_by_price(query)
    if @params[:price_from].present? && @params[:price_to].present?
      query.where(price: @params[:price_from]..@params[:price_to])
    elsif @params[:price_from].present?
      query.where('price >= ?', @params[:price_from])
    else
      query.where('price <= ?', @params[:price_to])
    end
  end
end
