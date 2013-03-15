# -*- coding: utf-8 -*-
describe Eretheal::Manager::Base do
  let(:pc) { FactoryGirl.create :character }
  subject { Eretheal::Manager::Base.new pc }
  describe '.initialize' do
    it 'characterオブジェクトを保持できる' do
      subject.pc.should be_instance_of Character
    end

    it 'Eretheal::Manager::Positionオブジェクトを保持できる' do
      subject.position.should be_instance_of Eretheal::Manager::Position
    end

    it 'messages配列を空で初期化できる' do
      subject.messages.should be_instance_of Array
      subject.messages.should have(0).items
    end

    it 'pc.current?をtrueにセットする' do
      subject.pc.should be_current
    end
  end

  describe '.add_message' do
    before do
      Message.create!(key: 'test', body: 'test message')
      Message.create!(key: 'hash-test', body: 'test message %{name} and %{body}')
    end

    it 'keyからMessageオブジェクトを取得する' do
      subject.add_message 'test'
      subject.messages.should have(1).messages
      subject.messages[0].should eq 'test message'
    end

    it 'hashを渡すと、文字列の中に展開できる' do
      subject.add_message 'hash-test', { name: 'hoge', body: 'huga'}
      subject.messages[0].should eq 'test message hoge and huga'
    end

    context '文字列をスタックできる' do
      before do
        2.times {subject.add_message 'test'}
      end
      its(:messages) { should have(2).messages }
    end
  end

  describe '.finish' do 
    context 'pcオブジェクトに変化があるとき' do
      before do
        subject.pc.stub(:changed?).and_return(true)
      end
      it 'データを保存する' do
        subject.pc.should_receive(:save!)
        subject.finish
      end
    end

    context 'pc.positionオブジェクトに変化があるとき' do
      before do
        subject.pc.position.stub(:changed?).and_return(true)
      end
      it 'データを保存する' do
        subject.pc.should_receive(:save!)
        subject.finish
      end
    end

    context 'pcオブジェクトに変化がないとき' do
      before do
        subject.pc.stub(:changed?).and_return(false)
      end
      it 'データを保存しない' do
        subject.pc.should_not_receive(:save!)
        subject.finish
      end
    end

  end
end
