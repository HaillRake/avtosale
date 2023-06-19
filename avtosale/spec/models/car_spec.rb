# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Car do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:date_added) }
    it { is_expected.to validate_length_of(:make).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_length_of(:model).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0).only_integer }
    it { is_expected.to validate_numericality_of(:odometer).is_greater_than_or_equal_to(0).only_integer }
    it { is_expected.to validate_numericality_of(:year).is_greater_than(1900).only_integer }
    it { is_expected.to validate_numericality_of(:year).is_less_than_or_equal_to(Time.zone.today.year) }
  end
end
