# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sword_type, class: WeaponType do
    key 'sword'
    name 'Sword'
    range 2
  end

  factory :ax_type, class: WeaponType do
    key 'ax'
    name 'Ax'
    range 2
  end
end
