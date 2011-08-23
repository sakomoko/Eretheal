# -*- coding: utf-8 -*-
require 'spec_helper'

describe Belonging do
  describe 'Belonging#equip' do
    let(:equip) { Factory :equip }
    let(:belonging) { Factory :belonging, character: equip.character }

    context '武器Aを装備したとき' do
      before do
        belonging.item.item_type = Factory :sword_type
      end
      it { belonging.equip.should be_true }
      it '武器として装備されていること' do
        belonging.equip
        equip.weapon.should eq belonging
      end
    end

    context '鎧Aを装備したとき' do
      before do
        belonging.item.item_type = Factory :cloth_armor_type
      end
      it { belonging.equip.should be_true }
      it '鎧として装備されていること' do
        belonging.equip
        equip.armor.should eq belonging
      end

    end

    context '道具Aを装備したとき' do
      before do
        belonging.item.item_type = Factory :item_type
      end
      it { belonging.equip.should be_false }
    end
  end
end
