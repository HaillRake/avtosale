# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService do
  describe '.call' do
    let(:car1) { create(:car, make: 'Ford', model: 'Fusion') }
    let(:car2) { create(:car, year: 2022, price: 2000) }

    before do
      car1
      car2
    end

    context 'when searching by make and model' do
      it 'returns cars matching the make and model' do
        expect(described_class.call(make: car1.make,
                                    model: car1.model)).to match_array([car1])
      end

      it 'returns cars matching the make' do
        expect(described_class.call(make: car1.make)).to match_array([car1])
      end
    end

    context 'when searching by year range' do
      it 'returns cars within the specified year range' do
        year_to = car2.year
        expect(described_class.call(year_from: year_to,
                                    year_to: year_to)).to match_array([car2])
      end

      it 'returns cars with a year above the specified year' do
        expect(described_class.call(year_from: 2019)).to include(car2)
      end

      it 'returns cars with a year less than the specified year' do
        expect(described_class.call(year_to: 2019)).not_to include(car2)
      end
    end

    context 'when searching by price range' do
      it 'returns cars within the specified price range' do
        price_from = car2.price
        expect(described_class.call(price_from: price_from,
                                    price_to: 50_000)).to include(car2)
      end

      it 'returns cars with a price less than the specified price' do
        expect(described_class.call(price_to: car2.price)).to include(car2)
      end

      it 'returns cars with a price above the specified price' do
        expect(described_class.call(price_from: car2.price)).to include(car2)
      end
    end
  end
end
