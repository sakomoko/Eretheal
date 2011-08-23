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

    context '楯Aを装備したとき' do
      before do
        belonging.item.item_type = Factory :shield_type
      end
      it { belonging.equip.should be_true }
      it '楯として装備されていること' do
        belonging.equip
        equip.shield.should eq belonging
      end
    end

    context '楯を装備している状態で2H武器を装備したとき' do
      let(:shield) { Factory(:belonging, item: Factory(:shield_item), character: equip.character) }
      let(:two_handed) { Factory(:belonging, item: Factory(:two_handed_weapon), character: equip.character) }
      before do
        shield.equip
        two_handed.equip
      end
      it '楯が装備から外されていること' do
        equip.shield.should be_nil
      end
      it '2H武器が装備されていること' do
        equip.weapon.should eq two_handed
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
