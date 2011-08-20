# -*- coding: utf-8 -*-
require 'spec_helper'

describe Character do

  describe 'Belongings Extensions' do
    context 'アイテムAを所持しているとき' do
      before do
        @pc = Factory :character
        @pc.belongings << Factory(:belonging)
        @item = @pc.belongings.first.item
      end
      subject { @pc.belongings }
      it { should be_have @item.id }
    end

    context 'アイテムAを所持していないとき' do
      before do
        @pc = Factory :character
        @pc.belongings << Factory(:belonging)
        @item = Factory(:belonging).item
      end
      subject { @pc.belongings }
      it { should_not be_have @item.id }
    end

    context 'アイテムAを２個所持しているとき' do
      before do
        @pc = Factory :character
        @pc.belongings << Factory(:belonging, :num => 2)
        @item = @pc.belongings.first.item
      end
      subject { @pc.belongings }
      it { should be_have @item.id, 2 }
    end

    context 'アイテムAを２スタックに分けて合計１１個所持しているとき' do
      before do
        @pc = Factory :character
        @item = Factory :item
        @pc.belongings << Factory(:belonging, :item => @item, :num => 6)
        @pc.belongings << Factory(:belonging, :item => @item, :num => 5)
      end
      subject { @pc.belongings }
      it { should be_have @item.id, 11 }
    end
  end
end
