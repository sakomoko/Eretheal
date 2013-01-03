# -*- coding: utf-8 -*-
require 'spec_helper'

describe ItemType do
  describe 'keyからアイテムタイプを探すことができる' do
    let(:sword_type) { FactoryGirl.create :sword_type }
    before do
      sword_type
    end
    it { ItemType.find('sword').should eq sword_type }
  end
end
