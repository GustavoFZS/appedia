# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    title { Faker::Name.name }
    user
  end
end
