# -*- coding: utf-8 -*-
describe Eretheal::Response do
  let(:pc) { FactoryGirl.create :character }
  subject { Eretheal::Response.new(pc) }
  context 'インスタンスを作成したとき' do
    its(:character) { should eq pc }
  end
end
