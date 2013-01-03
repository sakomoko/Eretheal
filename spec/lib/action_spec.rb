# -*- coding: utf-8 -*-
describe Action do

  let(:skill) { FactoryGirl.create :skill }
  let(:inventory_item) { FactoryGirl.create :inventory_item }
  it 'SkillクラスがActionモジュールをインクルードしていること' do
    skill.is_a?(Action).should be_true
  end
  it 'InventoryItemクラスがActionモジュールをインクルードしていること' do
    inventory_item.is_a?(Action).should be_true
  end
end
