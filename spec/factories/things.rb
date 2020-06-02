# frozen_string_literal: true

FactoryBot.define do
  factory :thing do
    title { Faker::Name.name_with_middle }
    content { Faker::Book.title }
    content_type { %w[Video Image Url Text].sample }
    user
  end
end
