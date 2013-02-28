# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :constant do

    factory :constant_default_position do
      key 'default_position'
      association :constable, factory: :default_field
    end
  end
end
