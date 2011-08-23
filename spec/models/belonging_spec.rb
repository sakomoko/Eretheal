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

    context '2H武器の装備時に楯を装備したとき' do
      let(:shield) { Factory(:belonging, item: Factory(:shield_item), character: equip.character) }
      let(:two_handed) { Factory(:belonging, item: Factory(:two_handed_weapon), character: equip.character) }
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
        belonging.item.item_type = Factory :item_type
      end
      it { belonging.equip.should be_false }
    end
  end

  describe 'Belonging#remove' do
    shared_examples_for '所持品オブジェクトが削除されていること' do
      it { pc.belongings.where(_id: belonging.id).first.should be_nil }
      it { pc.belongings.should have(1).removed }
    end


    let(:belonging) { Factory :belonging, num: 5 }
    let(:pc) { belonging.character }
    context 'スタックされている所持品から１つ取り除くとき' do
      before do
        belonging.remove
      end
      it '残りのスタック数が１減っていること' do
        belonging.num.should eq 4
      end
    end
    context 'スタックされている所持品からすべてを取り除くとき' do
      before do
        belonging.remove 5
      end
      it_should_behave_like '所持品オブジェクトが削除されていること'
    end
    context 'スタックされている所持品から、所持数以上を取り除くとき' do
      it '例外が発生すること' do
        expect { belonging.remove 6 }.to raise_error(RuntimeError)
      end
    end

    describe 'スタック不能アイテムの場合' do
      let(:belonging) { Factory :belonging, item: :unstacked_item }
      context 'スタック不可能アイテムから、１つ取り除くとき' do
        before do
          belonging.remove
        end
        it_should_behave_like '所持品オブジェクトが削除されていること'
      end
    end


  end
end
