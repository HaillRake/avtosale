# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test1@gmail.com' }
    password { 'Q%%12345' }
  end
end
