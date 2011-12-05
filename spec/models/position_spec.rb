# -*- coding: utf-8 -*-
describe Position do
  describe 'Position#area' do
    context '子フィールドにいるとき' do
      let(:field) { Factory(:field) }
      let(:position) { Factory :position, field: field }
      let(:node) { Factory :node_field }
      before do
        node.children << field
      end
      it 'ルートエリアの情報を参照できること' do
        position.area.should eq node
      end
    end
  end

  describe 'Position#renew' do
    let(:field) { Factory :field }
    let(:position) { Factory :position, field: field }
    let(:parent) { Factory :field }
    let(:child) { Factory :field }
    let(:has_link) { Factory :link_field }
    let(:node) { Factory :node_field }
    let(:destination) { Factory :field, name: 'Destination' }
    subject { position }
    context '子フィールドへ移動したとき' do
      before do
        node.children << field
        field.children << destination
        position.renew destination
      end
      subject { position }
      its(:distance) { should eq 0 }
      its(:field) { should eq destination }
      its(:area) { should eq node }
    end
    context '親フィールドへ移動したとき' do
      before do
        node.children << parent
        parent.children << field
        field.children << destination
        position.renew parent
      end
      its(:distance) { should eq 0 }
      its(:field) { should eq parent }
      its(:area) { should eq node }
    end
    context 'リンクを持ったフィールドへ移動したとき' do
      let(:destination_root) { Factory :field, name: 'DestinationRoot' }
      before do
        has_link.parent = parent
        has_link.link = destination_root
        destination_root.children = nil
        has_link.parent = parent
        destination_root.children << destination
        position.renew has_link
      end
      its(:distance) { should eq 0 }
      its(:field) { should eq destination }
      its(:area) { should eq destination_root }
    end
    context 'ノードへ移動したとき' do
      before do
        node.children << parent
        position.renew node
      end
      its(:distance) { should eq 0 }
      its(:field) { should eq parent }
      its(:area) { should eq node }
    end
  end
end
