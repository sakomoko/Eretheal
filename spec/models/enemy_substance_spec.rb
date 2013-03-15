# -*- coding: utf-8 -*-
require 'spec_helper'

describe EnemySubstance do
  let(:enemy) { FactoryGirl.build :enemy_substance }
  describe '.convert' do
    subject { enemy.convert }
    it 'Enemyモデルのインスタンスを返すこと' do
      should be_instance_of Enemy
    end
    it 'Enemyオブジェクトにsubstanceがセットされていること' do
      subject.substance.should eq enemy
    end
  end

end
