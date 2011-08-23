# -*- coding: utf-8 -*-
require 'spec_helper'

describe Character do

  describe 'スタック可能アイテムAの入手機会があったとき' do
    before do
      @pc = Factory :character
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
        it { should be_have @item, 3 }
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
    let(:pc) { Factory :character }

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
  end

end
