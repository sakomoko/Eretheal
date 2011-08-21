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
    is_stack true
    price 100
    color '#ffffff'
  end

end
