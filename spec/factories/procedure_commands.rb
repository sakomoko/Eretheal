# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :procedure_command do
    factory :low_hp_enemy do
      key :low_hp_enemy
    end
  end
end
