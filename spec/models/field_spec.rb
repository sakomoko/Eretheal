# -*- coding: utf-8 -*-
require 'spec_helper'

describe Field do
  let(:field) { FactoryGirl.create :field }
  let(:parent) { FactoryGirl.create :field }
  let(:child) { FactoryGirl.create :field }
  let(:has_link) { FactoryGirl.create :link_field }
  let(:node) { FactoryGirl.create :node_field }
  before do
    node.children << parent
    field.parent = parent
    field.children << child
    field.link = has_link
  end

  describe "routes" do
    subject { field.routes }
    it { should be_instance_of Array }
    it { should eq [child, has_link, parent] }
    context 'ノード属性を持つ親エリアは進路に含まないこと' do
      subject { parent.routes }
      it { should eq [field] }
    end

    context "field has not link" do
      before do
        field.link = nil
      end
      it { should eq [child, parent] }
    end
  end
end
