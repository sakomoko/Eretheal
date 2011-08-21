# -*- coding: utf-8 -*-
require 'spec_helper'

describe Character do

  describe 'スタック可能アイテムAの入手機会があったとき' do
    context '既にアイテムAを所持している場合' do
      before do
        @pc = Factory :character
        @pc.belongings << Factory(:belonging)
        @item = @pc.belongings.first.item
        @num = @pc.belongings.first.num
      end
      subject { @pc.belongings }

      it { should be_have @item }
      it { should_not be_bag_over @item }
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
        @pc = Factory :character
        @pc.belongings << Factory(:belonging)
        @item = Factory(:item)
      end
      subject { @pc.belongings }
      it { should_not be_have @item }

      context 'バッグに余裕があれば' do
        before do
          @size = @pc.belongings.size
          @pc.belongings.add @item, 3
        end
        subject { @pc.belongings }
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
        subject { @pc.belongings }
        it { should be_bag_over @item }
      end
    end

    context 'アイテムAを２個所持している場合' do
      before do
        @pc = Factory :character
        @pc.belongings << Factory(:belonging, :num => 2)
        @item = @pc.belongings.first.item
      end
      subject { @pc.belongings }
      it { should be_have @item, 2 }
    end

    context 'アイテムAを２スタックに分けて合計１１個所持しているとき' do
      before do
        @pc = Factory :character
        @item = Factory :item
        @pc.belongings << Factory(:belonging, :item => @item, :num => 6)
        @pc.belongings << Factory(:belonging, :item => @item, :num => 5)
      end
      subject { @pc.belongings }
      it { should be_have @item, 11 }
    end
  end

end
