# -*- coding: utf-8 -*-
require 'spec_helper'

describe ItemType do
  context 'アイテムAを装備可能かどうか診断したとき' do
    subject { item }
    context '装備可能なアイテムであれば' do
      let(:item) { Factory :item, :item_type => Factory(:sword_type) }
      its(:item_type) { should be_equip }
    end

    context '装備可能なアイテムでなければ' do
      let(:item) { Factory :item, :item_type => Factory(:item_type) }
      its(:item_type) { should_not be_equip }
    end

  end
end
