# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CarSortingService do
  describe '.call' do
    let(:car1) { create(:car, price: 1000, date_added: '2020-02-12') }
    let(:car2) { create(:car, price: 2000, date_added: '2022-01-28') }

    before do
      car1
      car2
    end

    context 'when sorting by price_asc' do
      it 'returns cars sorted by price' do
        expect(described_class.call(Car.all, 'price_asc')).to match_array([car1, car2])
      end
    end

    context 'when sorting by date_added_desc' do
      it 'returns cars sorted by date_added' do
        expect(described_class.call(Car.all, 'date_added_desc')).to eq [car2, car1]
      end
    end
  end
end
