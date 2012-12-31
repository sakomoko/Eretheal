# -*- coding: utf-8 -*-
describe Eretheal::Formula do
  let(:formula) { Eretheal::Formula.new }
  let(:character) { FactoryGirl.create :character, equip: FactoryGirl.create(:equip) }
  let(:enemy) { FactoryGirl.create :enemy }
  let(:sword) { FactoryGirl.create :belonging, item: FactoryGirl.create(:sword_item, speed: -1, add_dex: 1), character: character}
  let(:armor) { FactoryGirl.create :belonging, item: FactoryGirl.create(:armor_item, add_vit: 1), character: character}
  before do
    sword.equip
    armor.equip
    enemy.level = 1
  end

  context 'HP/MPの最大値を得られること' do
    [:hp, :mp].each do |type|
      it { formula.send("max_#{type.to_s}", character).should be_integer }
    end
  end

  context 'スピード値が整数として得られること' do
    it { formula.speed(6).should be_integer }
  end
end
