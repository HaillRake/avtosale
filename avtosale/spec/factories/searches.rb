# frozen_string_literal: true

FactoryBot.define do
  factory :search do
    make { FFaker::Lorem.word + FFaker::Lorem.word }
    model { FFaker::Lorem.word + FFaker::Lorem.word }
    year_from { FFaker::Number.rand(2000..2010) }
    year_to { FFaker::Number.rand(2010..2023) }
    price_from { FFaker::Number.rand(1000..50_000) }
    price_to { FFaker::Number.rand(50_000..100_000) }
  end
end
