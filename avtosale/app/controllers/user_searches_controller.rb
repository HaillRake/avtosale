# frozen_string_literal: true

class UserSearchesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home help]

  def home
    session[:previous_params] = nil
  end

  def help; end

  def my_searches
    @user = User.find(current_user.id)
    @my_searches = @user.searches.all
  end
end
