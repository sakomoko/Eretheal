FactoryGirl.define do
  factory :inventory_item do
    character
    item
    num 1
    factory :inventory_sword_item do
      association :item, factory: :sword_item
    end

    factory :inventory_armor_item do
      association :item, factory: :armor_item
    end

    factory :inventory_shield_item do
      association :item, factory: :shield_item
    end


  end
end
