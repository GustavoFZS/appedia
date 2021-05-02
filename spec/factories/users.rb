# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }

    factory :user_with_tags do
      transient do
        tags_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:tag, evaluator.tags_count, user: user)
      end
    end

    factory :user_with_things do
      transient do
        things_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:thing, evaluator.things_count, user: user)
      end
    end
  end
end
