# -*- coding: utf-8 -*-
describe Action do
  let(:skill) { FactoryGirl.create :skill }
  let(:belonging) { FactoryGirl.create :belonging }
  it 'SkillクラスがActionモジュールをインクルードしていること' do
    skill.is_a?(Action).should be_true
  end
  it 'BelongingクラスがACtionモジュールをインクルードしていること' do
    belonging.is_a?(Action).should be_true
  end
end
