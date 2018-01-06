FactoryGirl.define do
  factory :level do
    association :diagnostic
    reading_level 1
    number_of_tested_words 100
    phonics_score 99
    fluency_score 1
    comprehension_score 1

    trait :invalid do
      reading_level nil
    end

    trait :level_params do
      reading_level '1'
      number_of_tested_words '1'
      phonics_score '1'
      fluency_score '1'
      comprehension_score '1'
    end

  end
end
