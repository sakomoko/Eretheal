# -*- coding: utf-8 -*-
require 'spec_helper'

describe ActionReport do
  let(:pc) { FactoryGirl.create :character }
  let(:enemy_group) { FactoryGirl.create :enemy_group, enemy_sets: [enemy_set] }
  let(:enemy_set) { FactoryGirl.build :enemy_set, level: 5, num: 1, enemy: enemy }
  let(:report) { FactoryGirl.build :action_report }
  let(:enemy) { FactoryGirl.create :enemy }
  subject { report }
  describe '.enemy_group=' do
    context '一種類一体のエネミーをセットしたとき' do
      before do
        report.enemy_group = enemy_group
      end
      it 'ActionReport::Enemyを一つ持つこと' do
        subject.enemies.should have(1).enemy
      end
      it 'セットしたEnemyが正しく関連づけられていること' do
        subject.enemies.first.body.should eq enemy
      end

      it 'レベルが正しくセットされていること' do
        subject.enemies.first.level.should eq 5
      end

      it 'HPが最大値にセットされていること' do
        subject.enemies.first.hp.should eq subject.enemies.first.max_hp
      end

      it 'MPが最大値にセットされていること' do
        subject.enemies.first.mp.should eq subject.enemies.first.max_mp
      end
    end
  end

  describe '.to_a' do
    before do
      pc.action_report = report
      report.enemy_group = enemy_group
    end
    subject { report.to_a }
    it '配列が返ること' do
      should be_instance_of Array
    end
    it 'pcとenemyを含んでいること' do
      subject[0].should eq pc
      subject[1].should be_instance_of EnemySubstance
    end
  end
end
