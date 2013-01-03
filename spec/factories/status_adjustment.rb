FactoryGirl.define do
  factory :status_adjustment do
    dmg 0
    defence 0
    hit 0
    avoid 0
    magi 0
    magi_defence 0
    dex 0
    agi 0
    int 0
    vit 0
    str 0
    mnd 0
    hp 0
    mp 0

    factory :dex_adjustment do
      dex 1
    end
  end
end
