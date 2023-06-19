# frozen_string_literal: true

class SearchSaverService < BaseService
  def initialize(search_params, current_user)
    @search_params = search_params
    @current_user = current_user
  end

  def call
    new_search = Search.with_params(@search_params)
    if new_search.exists?
      user_search = { search_id: new_search.first.id, user_id: @current_user.id }
      SearchesUser.create(user_search) if SearchesUser.with_params(user_search).none?
    else
      normalized_params = Search.normalize_params(@search_params)
      @current_user.searches.create(normalized_params)
    end
  end
end
