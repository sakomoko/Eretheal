require 'factory_girl'
FactoryGirl.define do

  sequence :name do |n|
    "Test User#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user, :aliases => [:other_user] do
    name
    email
    passowrd 'please'
  end

  factory :character, :aliases => [:other_character] do
    name 'Test Character'
    hp 20
    mp 10
    dex 6
    agi 6
    str 6
    int 6
    vit 6
    mnd 6

    bag_size 12
  end

  factory :belonging  do
    character
    item
    num 1
  end

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

    factory :two_handed_weapon, traits: [:unstacked] do
      two_handed true
      association :item_type, :factory => :sword_type
    end
    factory :shield_item, traits: [:unstacked] do
      association :item_type, :factory => :shield_type
    end
  end

  factory :equip do
    character
  end

  factory :item_type do
    key 'item'
    name 'Item'
    category 'item'
    range 0
    equip false

    factory :sword_type do
      key 'sword'
      name 'Sword'
      category 'weapon'
      range 2
      equip true
    end

    factory :spear_type do
      key 'spear'
      name 'Spear'
      category 'weapon'
      range 2
      equip true
    end

    factory :cloth_armor_type do
      key 'cloth_armor'
      name 'ClothArmor'
      category 'armor'
      equip true
    end

    factory :shield_type do
      key 'shield'
      name 'Shield'
      category 'shield'
      equip true
    end
  end

end
