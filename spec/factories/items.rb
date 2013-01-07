FactoryGirl.define do
  factory :item do
    power 0
    speed 0
    weight 1
    two_handed false
    stack true
    price 100
    color '#ffffff'
    item_type

    trait :unstacked do
      stack false
    end

    factory :unstacked_item, traits: [:unstacked]

    factory :sword_item, traits: [:unstacked] do
      association :item_type, :factory => :weapon_type
      association :equip_category, factory: :weapon_category
      association :weapon_type, factory: :sword_type
    end

    factory :two_handed_weapon, traits: [:unstacked] do
      two_handed true
      association :item_type, :factory => :weapon_type
      association :equip_category, factory: :weapon_category
      association :weapon_type, factory: :sword_type
    end

    factory :shield_item, traits: [:unstacked] do
      association :item_type, :factory => :shield_type
      association :equip_category, factory: :shield_category
    end

    factory :armor_item, traits: [:unstacked] do
      association :item_type, :factory => :cloth_armor_type
      association :equip_category, factory: :armor_category
    end

  end

end
