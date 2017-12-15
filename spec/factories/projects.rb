FactoryGirl.define do
  factory :project do
    association :facilitator
    name 'MyString'
    estimated_start_date { Date.current }
    estimated_end_date { Date.current + 7.days }

    trait :invalid do
      estimated_end_date Date.current - 7.days
    end
  end
end
