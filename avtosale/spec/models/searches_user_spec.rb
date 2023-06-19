# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchesUser do
  let(:price_to) { FFaker::Number.rand(50_000..100_000) }
  let(:year_from) { FFaker::Number.rand(2000..2010) }
  let(:make) { FFaker::Company.name }
  let(:search) { create(:search, make: make, year_from: year_from, price_to: price_to) }
  let(:user) { User.create(email: 'test1@test.com', password: 'M%%45678') }

  before do
    user
    search
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:search) }
  end

  describe 'creating a new record' do
    it 'creates a new record' do
      expect { described_class.create(search: search, user: user) }.to change(described_class, :count).by(1)
    end
  end

  describe 'scope' do
    context 'when searching by search and user' do
      it 'returns search matching the make and model' do
        expect(described_class.with_params(search_id: search,
                                           user_id: user)).to match_array(described_class.where(
                                                                            search_id: 1, user_id: 1
                                                                          ))
      end
    end
  end
end
