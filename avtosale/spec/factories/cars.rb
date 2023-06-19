# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    make { FFaker::Lorem.word + FFaker::Lorem.word }
    model { FFaker::Lorem.word + FFaker::Lorem.word }
    year { FFaker::Number.rand(1901..2023) }
    odometer { FFaker::Number.rand(50_000..500_000) }
    price { FFaker::Number.rand(1000..50_000) }
    description { FFaker::Vehicle.transmission }
    date_added { Time.zone.now.strftime('%d/%m/%Y') }
  end
end
