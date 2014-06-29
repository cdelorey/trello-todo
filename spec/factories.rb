FactoryGirl.define do   
  factory :card do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "card_#{n}" }
  end
end