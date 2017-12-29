FactoryGirl.define do
  factory :level do
    reading_level 1
    number_of_tested_words 1
    phonics_score 1
    fluency_score 1
    comprehension_score 1
    diagnostic nil

    trait :invalid do
      reading_level nil
    end
  end
end
