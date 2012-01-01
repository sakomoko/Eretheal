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
    password 'please'
  end

  factory :character, :aliases => [:other_character] do
    sequence(:name) { |n| "TestCharacter#{n}" }
    level 1
    hp 20
    mp 10
    dex 6
    agi 6
    str 6
    int 6
    vit 6
    mnd 6

    bag_size 12

    association :job, :factory => :warrior
  end

  factory :position do
    character
    field
  end

  factory :field do
    name 'Field'
    distance 10
    no_image false

    factory :node_field do
      no_image true
    end

    factory :link_field do
      name 'HasLinkField'
      association :link, :factory => :field
    end
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

    factory :sword_item, traits: [:unstacked] do
      association :item_type, :factory => :sword_type
    end
    factory :two_handed_weapon, traits: [:unstacked] do
      two_handed true
      association :item_type, :factory => :sword_type
    end
    factory :shield_item, traits: [:unstacked] do
      association :item_type, :factory => :shield_type
    end
    factory :armor_item, traits: [:unstacked] do
      association :item_type, :factory => :cloth_armor_type
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

  factory :enemy do
    name 'Enemy'
    dex 6
    agi 6
    int 6
    vit 6
    str 6
    mnd 6
  end

  factory :job do
    name 'Job'
    add_dex 1
    add_agi 1
    add_str 1
    add_int 1
    add_vit 1
    add_mnd 1

    factory :warrior do
      name 'Warrior'
      add_str 1.2
      add_int 0.8
      add_vit 1.1
      dex_up 1
      agi_up 1
      vit_up 1
    end

    factory :chanter do
      name 'Chanter'
      add_int 1.2
      add_mnd 1.1
      add_vit 0.8
      int_up 1
      vit_up 1
      mnd_up 1
    end
  end

  factory :skill do
    name 'Skill'
    active true

    trait :active do
      active true
    end
    trait :passive do
      active false
    end

    factory :attack_skill, traits: [:active] do
      name 'attack'
    end
    factory :defence_skill, traits: [:active] do
      name 'defence'
    end
    factory :escape_skill, traits: [:active] do
      name 'escape'
    end

  end

  factory :assigned_skill do
    character
    skill
  end
end
