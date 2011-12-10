# -*- coding: utf-8 -*-
describe Dice do
  context 'ダイスの種別を指定して静的にメソッドを呼び出せること' do
    it { Dice.roll("2d6").should be_integer }
    it 'Randomがダイス種別に応じた引数で呼び出されること' do
      Random.should_receive(:rand).with(6).any_number_of_times.and_return(3)
      Dice.roll "2d6"
    end
    it 'Randomがダイス個数に応じた回数呼び出されること' do
      Random.should_receive(:rand).with(6).exactly(3).times.and_return(3)
      Dice.roll "3d6"
    end
    it 'Randomの返値をダイス個数分合計して返すこと' do
      Random.should_receive(:rand).with(6).exactly(3).times.and_return(2)
      Dice.roll("3d6").should eq 9
    end
  end
  context 'パースできない引数が渡されたとき' do
    ["d100", "hoge", 100].each do |example|
      it { lambda { Dice.roll example }.should raise_error }
    end
  end
end
