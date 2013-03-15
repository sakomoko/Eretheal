# -*- coding: utf-8 -*-
describe Eretheal::Manager::Position do
  let(:pc) { FactoryGirl.create :character }
  let(:manager) { Eretheal::Manager.new pc }
  subject { manager.position }

  describe '.new' do
    it 'baseオブジェクトにアクセスできる' do
      subject.base.should be_instance_of Eretheal::Manager::Base
    end
  end

  describe '.go' do
    before do
      Field.create_seed
      pc.position.renew Field.find '4ef01063c54d2d3149000002'
      subject.stub(:add_message)
    end

    it '引数に与えたフィールドへ移動できる' do
      subject.go '4ef01063c54d2d3149000003'
      subject.pc.position.field.should eq Field.find '4ef01063c54d2d3149000003'
    end

    it 'encount?がコールされる' do
      subject.should_receive(:encount?)
      subject.go '4ef01063c54d2d3149000003'
    end
  end

  describe '.encount?' do
    subject { manager.position.encount? }

    context 'encount_probabilityが0%のとき' do
      before do
        pc.position.stub(:encount_probability).and_return(0)
        Random.should_receive(:rand).with(100).and_return(0)
      end
      it '必ずfalseが返ること' do
        should be_false
      end
    end

    context 'encount_probabilityが100%のとき' do
      before do
        pc.position.stub(:encount_probability).and_return(100)
        Random.should_receive(:rand).with(100).and_return(0)
      end
      it '必ずtrueが返ること' do
        should be_true
      end
    end
  end

  describe '.encount!' do
    before do
      field = FactoryGirl.create(:field, encount_probability: 100)
      subject.pc.position.field = field
      [20, 30, 40].each do |value|
        FactoryGirl.create(:encounter, probability: value, field: field)
      end

      subject.stub(:add_message)
    end

    it '遭遇メッセージがスタックされること' do
      subject.should_receive(:add_message).with('encount-enemy')
      subject.encount!
    end

    it 'ActionReportが作成されていること' do
      subject.encount!
      pc.action_report.should be_instance_of ActionReport
    end
  end

end
