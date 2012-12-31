# -*- coding: utf-8 -*-
require 'spec_helper'

describe Character do

  describe 'スタック可能アイテムAの入手機会があったとき' do
    before do
      @pc = FactoryGirl.create :character, equip: FactoryGirl.create(:equip)
    end
    subject { @pc.inventory }

    context '既にアイテムAを所持している場合' do
      before do
        @pc.inventory << FactoryGirl.create(:inventory_item)
        @item = @pc.inventory.first.item
        @num = @pc.inventory.first.num
      end

      it { should be_have @item }
      it 'アイテムAを参照できること' do
        inventory_item = @pc.inventory.where(item_id: @item.id).first
        inventory_item.item.id.should eq @item.id
      end

      context 'アイテムを1個入手したのなら' do
        before do
          @pc.inventory.add @item
        end
        it 'スタック個数が１増えること' do
          @pc.inventory.first.num.should eq @num + 1
        end
      end

      context 'アイテムを3個を入手したのなら' do
        before do
          @pc.inventory.add @item, 3
        end
        it 'スタック個数が3増えること' do
          @pc.inventory.first.num.should eq @num + 3
        end
      end
    end

    context 'アイテムAを所持していない場合' do
      before do
        @pc.inventory << FactoryGirl.create(:inventory_item)
        @item = FactoryGirl.create(:item)
      end

      it { should_not be_have @item }
      it { @pc.inventory.add(@item).should be_true }

      context 'バッグに余裕があれば' do
        before do
          @size = @pc.inventory.size
          @pc.inventory.add @item, 3
        end
        it 'inventoryにアイテムが追加されていること' do
          @pc.inventory.size.should eq @size + 1
        end
        it { @pc.inventory.should be_have @item, 3 }
        it { @pc.inventory.where(item_id: @item.id).first.color.should eq @item.color }
      end

      context 'バッグが他のアイテムでいっぱいだったら' do
        before do
          5.times { @pc.inventory << FactoryGirl.create(:inventory_item) }
          @pc.bag_size = 6
        end
        it { @pc.inventory.add(@item).should be_false }
      end
    end

    context 'アイテムAを２個所持している場合' do
      before do
        @pc.inventory << FactoryGirl.create(:inventory_item, :num => 2)
        @item = @pc.inventory.first.item
      end
      it { should be_have @item, 2 }
    end

    context 'アイテムAを２スタックに分けて合計１１個所持しているとき' do
      before do
        @item = FactoryGirl.create :item
        @pc.inventory << FactoryGirl.create(:inventory_item, :item => @item, :num => 6)
        @pc.inventory << FactoryGirl.create(:inventory_item, :item => @item, :num => 5)
      end
      it { should be_have @item, 11 }
    end
  end

  describe 'Inventory_ItemExtension#remove' do
    let(:pc) { FactoryGirl.create :character, equip: FactoryGirl.create(:equip) }

    context 'スタック可能アイテムの場合' do
      let(:item) { FactoryGirl.create :item }
      let(:inventory_item) { FactoryGirl.create(:inventory_item, item: item, num: 10) }
      before do
        pc.inventory << inventory_item
      end
      it { pc.inventory.remove(item, 5).should be_true }
      it '残り個数が５減っていること' do
        pc.inventory.remove(item, 5)
        pc.inventory.first.num.should eq 5
      end
      context 'スタックを分けて所持しているとき' do
        before do
          3.times do
            pc.inventory << FactoryGirl.create(:inventory_item, item: item, num: 5)
          end
          pc.inventory.remove item, 20
        end
        it { pc.inventory.should have(1).items }
      end
    end

    context 'スタック不可能アイテムの場合' do
      let(:item) { FactoryGirl.create :unstacked_item }
      subject { pc.inventory }
      before do
        3.times do
          pc.inventory << FactoryGirl.create(:inventory_item, item: item)
        end
        subject.remove item, 2
      end
      it { should have(1).items }
      it { should have(2).removed }
    end

    context '装備中のアイテムが含まれている場合' do
      let(:item) { FactoryGirl.create :sword_item }
      before do
        10.times do
          pc.inventory << FactoryGirl.create(:inventory_item, item: item)
        end
        pc.inventory.first.equip
        @inventory_item_id = pc.inventory.first.id
        pc.inventory.remove item, 8
      end
      it '装備中のアイテムは削除されないこと' do
        pc.inventory.find(@inventory_item_id).should_not be_nil
      end
    end
  end

  describe 'Inventory_ItemExtension#have?' do
    let(:pc) { FactoryGirl.create :character, equip: FactoryGirl.create(:equip) }
    let(:item) { FactoryGirl.create :sword_item }
    context '所持品の内一つが装備中のとき' do
      before do
        3.times do
          pc.inventory << FactoryGirl.create(:inventory_item, item: item)
        end
        pc.inventory.first.equip
      end
      it { pc.inventory.should_not be_have item, 3 }
      it { pc.inventory.should be_have item, 2 }
    end
  end

  describe 'Character#action=' do
    let(:pc) { FactoryGirl.create :character }
    let(:skill) { FactoryGirl.create :skill }
    let(:inventory_item) { FactoryGirl.create :inventory_item }
    context 'アサインされたスキルをセットするとき' do
      before do
        pc.assigned_skills << FactoryGirl.create(:assigned_skill, skill: skill)
        pc.action = skill
      end
      it 'アクションがセットされていること' do
        pc.action.should eq skill
      end
    end

    context 'アサインされていないスキルをセットしたとき' do
      it '例外が発生すること' do
        expect { pc.action = skill }.to raise_error
      end
      context 'スキルがデフォルトアクションの場合' do
        before do
          action_key = Eretheal::Application.config.default_actions[0]
          skill.name = action_key.to_s
          pc.action = skill
        end
        it '正しくセットされていること'do
          pc.action.should eq skill
        end
      end
    end

    context '所持品をセットするとき' do
      before do
        pc.inventory << inventory_item
        pc.action = inventory_item
      end
      it 'アクションがセットされていること' do
        pc.action.should eq inventory_item
      end
    end

    context '所持品でないものをセットするとき' do
      it '例外が発生すること' do
        expect { pc.action = inventory_item }.to raise_error
      end
    end
  end

  describe 'Character#set_default_documents' do
    let(:character) { Character.new }
    before do
      character.send(:set_default_documents)
    end
    it { character.position.class.should eq Position }
    it { character.position.field_id.to_s.should eq Eretheal::Application.config.default_position }
  end
end
