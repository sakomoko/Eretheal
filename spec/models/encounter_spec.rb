# -*- coding: utf-8 -*-
require 'spec_helper'

describe Encounter do
  describe '.create_seed' do
    before do
      Field.create_seed
      Enemy.create_seed
      EnemyGroup.create_seed
      Encounter.create_seed
    end

    subject { Encounter.first }
    it '投入したYAMLデータが一致する' do
      subject.probability.should eq 20
    end
    it 'Field関連が保存できている' do
      subject.field.should be_instance_of Field
    end

    it 'EnemyGroup関連が保存できている' do
      subject.enemy_group.should be_instance_of EnemyGroup
    end

  end
end
