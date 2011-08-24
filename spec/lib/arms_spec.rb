# -*- coding: utf-8 -*-
describe Arms do
  subject { Enemy }

  let(:character) { Factory :character }
  let(:enemy) { Factory :enemy }
  before do
    enemy.level = 1
    pp enemy.max_hp
  end

  context 'HP最大値を整数として得られること' do
    it { character.max_hp.should be_integer }
    it { enemy.max_hp.should be_integer }
  end
  context 'MP最大値を整数として得られること' do
    it { character.max_mp.should be_integer }
    it { enemy.max_mp.should be_integer }
  end
end
