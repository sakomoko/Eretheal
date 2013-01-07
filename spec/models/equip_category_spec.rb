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
end
