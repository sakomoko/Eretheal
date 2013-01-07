# -*- coding: utf-8 -*-
require 'spec_helper'

describe ItemType do
  describe 'keyからアイテムタイプを探すことができる' do
    let(:weapon_type) { FactoryGirl.create :weapon_type }
    before do
      weapon_type
    end
    it { ItemType.find('weapon').should eq weapon_type }
  end
end
