# -*- coding: utf-8 -*-
require 'spec_helper'

describe EquipCategory do
  let(:weapon_category) { FactoryGirl.create(:weapon_category) }
  describe 'keyからドキュメントを探すことができること' do
    before do
      weapon_category
    end
    it { EquipCategory.find('weapon').should eq weapon_category }
  end

  describe '装備品かどうかを真偽できること' do
    subject { weapon_category }
    it { should be_equip }

    context '対象が素材のとき' do
      subject { FactoryGirl.create(:material_category) }
      it { should_not be_equip }
    end
  end
end
