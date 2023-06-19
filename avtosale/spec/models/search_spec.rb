# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search do
  describe 'associations' do
    it { is_expected.to have_many(:searches_users).dependent(:delete_all) }
    it { is_expected.to have_many(:users).through(:searches_users) }
  end

  describe '.with_params' do
    let(:search) { create(:search) }

    before { search }

    context 'when given parameters have unique combination' do
      let(:params) { attributes_for(:search) }

      it 'returns an empty array' do
        expect(described_class.with_params(params)).to be_empty
      end
    end

    context 'when given parameters are not unique combination' do
      let(:params) { attributes_for(:search) }

      it 'returns an array' do
        expect(described_class.with_params(params)).to eq described_class.where(params)
      end
    end
  end

  describe '.normalize_params' do
    it 'converts all parameter to lowercase' do
      params = { make: 'FORD', model: 'FUsioN' }
      normalized_params = described_class.normalize_params(params)
      expect(normalized_params).to eq({ make: 'ford', model: 'fusion' })
    end

    it 'does not modify the original parameter hash' do
      params = { make: 'FORD', model: 'FUsioN' }
      described_class.normalize_params(params)
      expect(params).to eq({ make: 'FORD', model: 'FUsioN' })
    end
  end
end
