# -*- coding: utf-8 -*-
describe Eretheal::Formula do
  let(:character) { Factory :character, equip: Factory(:equip) }
  let(:enemy) { Factory :enemy }
  let(:sword) { Factory :belonging, item: Factory(:sword_item, speed: -1, add_dex: 1), character: character}
  let(:armor) { Factory :belonging, item: Factory(:armor_item, add_vit: 1), character: character}
  before do
    sword.equip
    armor.equip
    enemy.level = 1
  end

  context 'HP/MPの最大値を得られること' do
    [:hp, :mp].each do |type|
      it { Eretheal::Formula.send("max_#{type.to_s}", character).should be_integer }
    end
  end
end
