FactoryGirl.define do
  factory :level do
    association :diagnostic
    sequence(:reading_level, 1) { |n| n }
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

    trait :failing_phonics_score do
      number_of_tested_words 100
      phonics_score 91
    end

  end
end
