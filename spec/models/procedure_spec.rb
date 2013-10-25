# -*- coding: utf-8 -*-
require 'spec_helper'

describe Procedure do
  let(:character) { FactoryGirl.create :character }
  let(:enemy_a) { FactoryGirl.build(:enemy_substance).clean }
  let(:enemy_b) { FactoryGirl.build(:enemy_substance).clean }
  let(:actors) { [character, enemy_a, enemy_b] }

  # 最もHPの低い敵
  describe '.low_hp_enemy' do
    let(:low_hp_enemy) { FactoryGirl.create :low_hp_enemy }
    subject { FactoryGirl.build(:procedure, command: low_hp_enemy) }
    before do
      enemy_b.hp = 99
      subject.performer = character
    end
    it '最もHPの低い敵アクターが返ること' do
      subject.low_hp_enemy(actors).should eq enemy_a
    end
  end

  # 最もHPの低い味方
  describe '.low_hp_friend' do
    subject { FactoryGirl.build(:procedure) }
    before do
      enemy_b.hp = 99
      subject.performer = enemy_a
    end
    it '最もHPの低い味方アクターが返ること' do
      subject.low_hp_friend(actors).should eq enemy_a
    end
  end

end
