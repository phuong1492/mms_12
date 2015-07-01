FactoryGirl.define do
  factory :position do
    sequence(:name){|n| "position#{n}"}
  end
end
