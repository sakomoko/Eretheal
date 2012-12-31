# -*- coding: utf-8 -*-
require 'spec_helper'

describe Equip do
  context '所持品Aを武器として装備したとき' do
    before do
      @pc = FactoryGirl.create :character
      @pc.equip = FactoryGirl.create :equip
      @pc.belongings << FactoryGirl.create(:belonging)
      @pc.equip.weapon = @pc.belongings.first
    end
    it '武器と装備品は同一であること' do
      @pc.equip.weapon.id.should eq @pc.belongings.first.id
    end
  end

end
