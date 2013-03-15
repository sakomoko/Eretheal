require 'factory_girl'
FactoryGirl.define do

  sequence :name do |n|
    "Test User#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :key do |n|
    "key-#{n}"
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

    bag_size 12

    association :job, :factory => :warrior
    position { FactoryGirl.build(:position) }
  end

  factory :position do
    field
  end

  factory :field do
    name 'Field'
    distance 10
    no_image false

    factory :default_field do
      name 'DefaultField'
    end

    factory :node_field do
      no_image true
    end

    factory :link_field do
      name 'HasLinkField'
      association :link, :factory => :field
    end
  end


  factory :equip do
    character
  end


  factory :enemy do
    name 'Enemy'
    key
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
      dex_up 22
      agi_up 21
      vit_up 23
      int_up 19
      mnd_up 20
      str_up 23
    end

    factory :chanter do
      name 'Chanter'
      add_int 1.2
      add_mnd 1.1
      add_vit 0.8
      int_up 23
      vit_up 21
      mnd_up 23
      dex_up 20
      agi_up 20
      str_up 21
    end
  end

  factory :skill do
    name 'Skill'
  end

  factory :assigned_skill do
    character
    skill
  end
end
