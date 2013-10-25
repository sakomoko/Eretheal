# -*- coding: utf-8 -*-
require 'spec_helper'

describe EnemySubstance do
  let(:enemy) { FactoryGirl.create :enemy }
  let(:enemy_substance) { FactoryGirl.build :enemy_substance, body: enemy }
  describe '.new' do
    subject { enemy }
    it 'Enemyモデルのインスタンスを持っていること' do
      enemy_substance.body.should eq enemy
    end
  end

end
