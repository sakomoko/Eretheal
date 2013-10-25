# -*- coding: utf-8 -*-
describe Eretheal::Manager::Combat do
  let(:pc) { FactoryGirl.create :character }
  let(:enemy_group) { FactoryGirl.create :enemy_group }
  let(:manager) { Eretheal::Manager.new pc }
  let(:enemy) { FactoryGirl.create :enemy }
  let(:enemy_a) { FactoryGirl.build(:enemy_substance, body: enemy) }
  let(:enemy_b) { FactoryGirl.build(:enemy_substance, body: enemy) }

  describe '.new' do
    it 'baseにmanagerがセットされていること' do
      manager.combat.base.should eq manager
    end
    it 'actorsに空の配列がセットされていること' do
      manager.combat.actors.should eq []
    end
  end

  describe '.count' do
    before do
      manager.combat.actors = [enemy_a, enemy_b]
    end

    it '誰もチャージタイムが満たされない場合はfalseが返る' do
      enemy_a.speed.should eq 2
      enemy_a.charge_time.should eq 0
      manager.combat.count.should be_false
    end

    it 'スピード値の分だけチャージタイムが加算される' do
      manager.combat.count
      enemy_a.charge_time.should eq 2
    end

    it '一人でもチャージタイムが１００に達したときはtrueが返る' do
      enemy_a.charge_time = 98
      manager.combat.count.should be_true
    end
  end

  describe '.run' do
    before do
      manager.combat.actors = [enemy_a, enemy_b]
      manager.combat.stub(:execute_actions)
    end

    it 'actorsがセットされていないときは例外を投げる' do
      manager.combat.actors = []
      -> { manager.combat.run }.should raise_error(RuntimeError)
    end

    it 'チャージタイムの高いものの降順にactorsがソートされること' do
      enemy_b.charge_time = 50
      manager.combat.run
      manager.combat.actors.should eq [enemy_b, enemy_a]
    end

    it 'execute_actionsがコールされること' do
      manager.combat.should_receive(:execute_actions)
      manager.combat.run
    end
  end

end
