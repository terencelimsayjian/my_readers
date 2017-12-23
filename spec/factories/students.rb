FactoryGirl.define do
  factory :student do
    association :project
    name { Faker::Name.name }
    class_name '3 Gigih'
    phone_number "+60171234567"

    trait :without_phone_number do
      phone_number nil
    end

    trait :invalid do
      name nil
    end
  end
end
