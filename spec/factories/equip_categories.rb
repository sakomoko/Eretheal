# -*- coding: utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :equip_category do
    equip true

    factory :item_category do
      key 'item'
      name '道具'
      equip false
    end

    factory :weapon_category do
      key 'weapon'
      name '武器'
    end

    factory :bullet_category do
      key 'bullet'
      name '矢弾'
    end

    factory :armor_category do
      key 'armor'
      name '鎧'
    end

    factory :shield_category do
      key 'shield'
      name '楯'
    end

    factory :material_category do
      key 'material'
      name '素材'
      equip false
    end

  end
end
