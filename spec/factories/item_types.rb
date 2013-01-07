FactoryGirl.define do
  factory :item_type do
    key 'item'
    name 'Item'

    factory :weapon_type do
      key 'weapon'
      name 'Weapon'
    end

    factory :cloth_armor_type do
      key 'cloth_armor'
      name 'ClothArmor'
    end

    factory :shield_type do
      key 'shield'
      name 'Shield'
    end
  end
end
