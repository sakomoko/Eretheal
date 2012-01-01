# -*- coding: utf-8 -*-
require 'spec_helper'

describe Character do

  describe 'スタック可能アイテムAの入手機会があったとき' do
    before do
      @pc = Factory :character, equip: Factory(:equip)
    end
    subject { @pc.belongings }

    context '既にアイテムAを所持している場合' do
      before do
        @pc.belongings << Factory(:belonging)
        @item = @pc.belongings.first.item
        @num = @pc.belongings.first.num
      end

      it { should be_have @item }
      it 'アイテムAを参照できること' do
        belonging = @pc.belongings.where(item_id: @item.id).first
        belonging.item.id.should eq @item.id
      end

      context 'アイテムを1個入手したのなら' do
        before do
          @pc.belongings.add @item
        end
        it 'スタック個数が１増えること' do
          @pc.belongings.first.num.should eq @num + 1
        end
      end

      context 'アイテムを3個を入手したのなら' do
        before do
          @pc.belongings.add @item, 3
        end
        it 'スタック個数が3増えること' do
          @pc.belongings.first.num.should eq @num + 3
        end
      end
    end

    context 'アイテムAを所持していない場合' do
      before do
        @pc.belongings << Factory(:belonging)
        @item = Factory(:item)
      end

      it { should_not be_have @item }
      it { @pc.belongings.add(@item).should be_true }

      context 'バッグに余裕があれば' do
        before do
          @size = @pc.belongings.size
          @pc.belongings.add @item, 3
        end
        it 'belongingsにアイテムが追加されていること' do
          @pc.belongings.size.should eq @size + 1
        end
        it { @pc.belongings.should be_have @item, 3 }
        it { @pc.belongings.where(item_id: @item.id).first.color.should eq @item.color }
      end

      context 'バッグが他のアイテムでいっぱいだったら' do
        before do
          5.times { @pc.belongings << Factory(:belonging) }
          @pc.bag_size = 6
        end
        it { @pc.belongings.add(@item).should be_false }
      end
    end

    context 'アイテムAを２個所持している場合' do
      before do
        @pc.belongings << Factory(:belonging, :num => 2)
        @item = @pc.belongings.first.item
      end
      it { should be_have @item, 2 }
    end

    context 'アイテムAを２スタックに分けて合計１１個所持しているとき' do
      before do
        @item = Factory :item
        @pc.belongings << Factory(:belonging, :item => @item, :num => 6)
        @pc.belongings << Factory(:belonging, :item => @item, :num => 5)
      end
      it { should be_have @item, 11 }
    end
  end

  describe 'BelongingExtension#remove' do
    let(:pc) { Factory :character, equip: Factory(:equip) }

    context 'スタック可能アイテムの場合' do
      let(:item) { Factory :item }
      let(:belonging) { Factory(:belonging, item: item, num: 10) }
      before do
        pc.belongings << belonging
      end
      it { pc.belongings.remove(item, 5).should be_true }
      it '残り個数が５減っていること' do
        pc.belongings.remove(item, 5)
        pc.belongings.first.num.should eq 5
      end
      context 'スタックを分けて所持しているとき' do
        before do
          3.times do
            pc.belongings << Factory(:belonging, item: item, num: 5)
          end
          pc.belongings.remove item, 20
        end
        it { pc.belongings.should have(1).items }
      end
    end

    context 'スタック不可能アイテムの場合' do
      let(:item) { Factory :unstacked_item }
      subject { pc.belongings }
      before do
        3.times do
          pc.belongings << Factory(:belonging, item: item)
        end
        subject.remove item, 2
      end
      it { should have(1).items }
      it { should have(2).removed }
    end

    context '装備中のアイテムが含まれている場合' do
      let(:item) { Factory :sword_item }
      before do
        10.times do
          pc.belongings << Factory(:belonging, item: item)
        end
        pc.belongings.first.equip
        @belonging_id = pc.belongings.first.id
        pc.belongings.remove item, 8
      end
      it '装備中のアイテムは削除されないこと' do
        pc.belongings.find(@belonging_id).should_not be_nil
      end
    end
  end

  describe 'BelongingExtension#have?' do
    let(:pc) { Factory :character, equip: Factory(:equip) }
    let(:item) { Factory :sword_item }
    context '所持品の内一つが装備中のとき' do
      before do
        3.times do
          pc.belongings << Factory(:belonging, item: item)
        end
        pc.belongings.first.equip
      end
      it { pc.belongings.should_not be_have item, 3 }
      it { pc.belongings.should be_have item, 2 }
    end
  end

  describe 'Character#action=' do
    let(:pc) { Factory :character }
    let(:skill) { Factory :skill }
    let(:belonging) { Factory :belonging }
    context 'アサインされたスキルをセットするとき' do
      before do
        pc.assigned_skills << Factory(:assigned_skill, skill: skill)
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
        pc.belongings << belonging
        pc.action = belonging
      end
      it 'アクションがセットされていること' do
        pc.action.should eq belonging
      end
    end

    context '所持品でないものをセットするとき' do
      it '例外が発生すること' do
        expect { pc.action = belonging }.to raise_error
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
