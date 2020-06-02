# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    title { Faker::Name.name_with_middle }
    user
  end
end
