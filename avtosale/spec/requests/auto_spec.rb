require 'rails_helper'

RSpec.describe "Autos", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/auto/index"
      expect(response).to have_http_status(:success)
    end
  end

end
