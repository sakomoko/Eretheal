# -*- coding: utf-8 -*-
require 'spec_helper'

describe InventoryItem do
  let(:pc) { FactoryGirl.create :character, equip: (FactoryGirl.create :equip) }
  let(:inventory_item) { FactoryGirl.create :inventory_item, character: pc }

  describe 'Itemモデルのメソッドに委譲することができること' do
    subject { inventory_item }
    its(:item_type) { should eq inventory_item.item.item_type }
    its(:weight) { should eq inventory_item.item.weight }
    it { should_not be_equip }
  end

  describe '#equip' do
    let(:equip) { pc.equip }
    context 'DEX+1の武器Aを装備したとき' do
      let(:inventory_item) { FactoryGirl.create :inventory_sword_item, character: pc }
      before do
        inventory_item.item.status_adjustment = FactoryGirl.create :dex_adjustment
      end
      it { inventory_item.equip.should be_true }
      it '武器として装備されていること' do
        inventory_item.equip
        equip.weapon.should eq inventory_item
      end
      it '能力値のメモ化が解除されていること' do
        pc.total_dex
        inventory_item.equip
        pc.total_dex.should eq 7
      end
    end

    context '鎧Aを装備したとき' do
      subject { FactoryGirl.create :inventory_armor_item, character: pc }
      it { subject.equip.should be_true }
      it '鎧として装備されていること' do
        subject.equip
        should eq pc.equip.armor
      end
    end

    context '楯Aを装備したとき' do
      subject { FactoryGirl.create :inventory_shield_item, character: pc }
      it { subject.equip.should be_true }
      it '楯として装備されていること' do
        subject.equip
        should eq pc.equip.shield
      end
    end

    context '楯を装備している状態で2H武器を装備したとき' do
      let(:shield) { FactoryGirl.create(:inventory_item, item: FactoryGirl.create(:shield_item), character: equip.character) }
      let(:two_handed) { FactoryGirl.create(:inventory_item, item: FactoryGirl.create(:two_handed_weapon), character: equip.character) }
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

    context '2H武器の装備時に楯を装備したとき' do
      let(:shield) { FactoryGirl.create(:inventory_item, item: FactoryGirl.create(:shield_item), character: equip.character) }
      let(:two_handed) { FactoryGirl.create(:inventory_item, item: FactoryGirl.create(:two_handed_weapon), character: equip.character) }
      before do
        two_handed.equip
        shield.equip
      end
      it '2H武器が装備から外されていること' do
        equip.weapon.should be_nil
      end
      it '楯が装備されていること' do
        equip.shield.should eq shield
      end

    end

    context '道具Aを装備したとき' do
      before do
        inventory_item.item.item_type = FactoryGirl.create :item_type
      end
      it { inventory_item.equip.should be_false }
    end
  end

  describe 'Inventory_Item#remove' do
    shared_examples_for '所持品オブジェクトが削除されていること' do
      it { pc.inventory.where(_id: inventory_item.id).first.should be_nil }
      it { pc.inventory.should have(1).removed }
    end
    let(:pc) { FactoryGirl.create :character, equip: FactoryGirl.create(:equip) }
    let(:inventory_item) { FactoryGirl.create :inventory_item, num: 5, character: pc }

    context 'スタックされている所持品から１つ取り除くとき' do
      before do
        inventory_item.remove
      end
      it '残りのスタック数が１減っていること' do
        inventory_item.num.should eq 4
      end
    end
    context 'スタックされている所持品からすべてを取り除くとき' do
      before do
        inventory_item.remove 5
      end
      it_should_behave_like '所持品オブジェクトが削除されていること'
    end
    context 'スタックされている所持品から、所持数以上を取り除くとき' do
      it '例外が発生すること' do
        expect { inventory_item.remove 6 }.to raise_error(RuntimeError)
      end
    end

    describe 'スタック不能アイテムの場合' do
      let(:inventory_item) { FactoryGirl.create :inventory_item, item: FactoryGirl.create(:unstacked_item), character: pc }
      context 'スタック不可能アイテムから、１つ取り除くとき' do
        before do
          inventory_item.remove
        end
        it_should_behave_like '所持品オブジェクトが削除されていること'
      end
      context '装備している所持品を削除するとき' do
        let(:sword) { FactoryGirl.create :inventory_item, item: FactoryGirl.create(:sword_item), character: pc }
        before do
          sword.equip
          sword.remove
        end
        it '所持品が削除されていないこと' do
          pc.inventory.find(sword.id).should be_true
        end
      end

    end
  end

  describe 'Inventory_Item#equipping?' do
    let(:pc) { FactoryGirl.create(:character, equip: FactoryGirl.create(:equip)) }
    let(:inventory_item) { FactoryGirl.create :inventory_item, item: FactoryGirl.create(:sword_item), character: pc }

    context 'ソードを装備したとき' do
      before do
        inventory_item.equip
      end
      it { inventory_item.should be_equipping }
    end
    context 'ソードを装備していないとき' do
      it { inventory_item.should_not be_equipping }
    end
  end

  describe 'InventoryItem#unequip' do
    let(:pc) { FactoryGirl.create(:character, equip: FactoryGirl.create(:equip)) }
    let(:inventory_item) { FactoryGirl.create :inventory_sword_item, character: pc }
    context '装備しているソード(DEX+1)を外すとき' do
      before do
        inventory_item.item.status_adjustment = FactoryGirl.create :dex_adjustment
        inventory_item.equip
        pc.total_dex
        inventory_item.unequip
      end
      it { inventory_item.should_not be_equipping }
      it { pc.equip.weapon.should be_nil }
      it '能力値のメモ化が解除されていること' do
        pc.total_dex.should eq 6
      end
    end
    context '装備していないソードを外すとき' do
      it { inventory_item.unequip.should be_false }
    end
    context '装備品でないアイテムを外すとき' do
      let(:inventory_item) { FactoryGirl.create :inventory_item, item: FactoryGirl.create(:item), character: pc }
      it { inventory_item.unequip.should be_false }
    end
  end

end
