# -*- coding: utf-8 -*-
describe Eretheal::Formula do
  subject { formula }
  let(:formula) { Eretheal::Formula.new }
  let(:character) { FactoryGirl.create :character, equip: FactoryGirl.create(:equip) }
  let(:enemy) { FactoryGirl.create :enemy }
  let(:sword) { FactoryGirl.create :inventory_item, item: FactoryGirl.create(:sword_item, speed: -1, status_adjustment: FactoryGirl.create(:status_adjustment, dex: 1)), character: character}
  let(:armor) { FactoryGirl.create :inventory_item, item: FactoryGirl.create(:armor_item, status_adjustment: FactoryGirl.create(:status_adjustment, vit: 1)), character: character}
  before do
    sword.equip
    armor.equip
    enemy.level = 1
  end

  describe '.max_hp' do
    it '.max_pointが呼ばれること' do
      subject.should_receive(:max_point)
      subject.max_hp(character.vit, character.level)
    end
  end

  describe '.max_mp' do
    it '.max_pointが呼ばれること' do
      subject.should_receive(:max_point)
      subject.max_mp(character.mnd, character.level)
    end
  end

  describe '.max_point' do
    it '数値は整数で返ること' do
      subject.max_point(character.vit, character.level).should be_integer
    end
  end

  describe '.speed' do
    it 'スピード値が整数として得られること' do
      subject.speed(6).should be_integer
    end

    context 'パラメータが6以下の場合は2が返ること' do
      it { subject.speed(0).should eq 2 }
      it { subject.speed(6).should eq 2 }
    end
  end

end
