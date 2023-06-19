# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSearchesController do
  describe 'GET #help' do
    it 'returns http success' do
      get :help
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #home' do
    it 'clears the session' do
      session[:previous_params] = { make: 'Honda' }
      get :home
      expect(session[:previous_params]).to be_nil
    end
  end

  describe 'GET #my_searches' do
    let(:user) { create(:user) }
    let(:search) { create(:search) }
    let(:searches_user) { SearchesUser.create(search: search, user: user) }

    before do
      user
      search
      searches_user
      sign_in user
    end

    it "assigns the user's searches as @my_searches" do
      get :my_searches, params: { user_id: user.id }
      expect(assigns(:my_searches)).to match_array(search)
    end

    it 'renders the my_search template' do
      get :my_searches
      expect(response).to render_template('my_searches')
    end
  end
end
