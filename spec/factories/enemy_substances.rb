# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :enemy_substance do
    association :body, factory: :enemy
  end
end
