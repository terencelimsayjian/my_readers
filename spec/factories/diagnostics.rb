FactoryGirl.define do
  factory :diagnostic do
    association :student
    index 1
  end
end
