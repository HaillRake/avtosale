# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchSaverService do
  let(:user) { create(:user) }
  let(:search_params) { { make: '', model: 'fusion', year_from: 2010 } }

  describe '.call' do
    define_negated_matcher :not_change, :change
    context 'when the search does not exist' do
      it 'creates a new search' do
        expect { described_class.call(search_params, user) }
          .to change(Search, :count).by(1)
          .and change(SearchesUser, :count).by(1)
      end
    end

    context 'when the search exist' do
      before do
        user
        SearchesUser.create(search_id: 1, user_id: user)
        Search.create(make: '', model: 'fusion', year_from: 2010)
      end

      it 'does not create a new search' do
        expect { described_class.call(search_params, user) }
          .to not_change(Search, :count)
      end
    end
  end
end
