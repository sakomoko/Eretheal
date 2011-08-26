# -*- coding: utf-8 -*-
describe Arms do
  subject { Enemy }

  let(:character) { Factory :character, equip: Factory(:equip) }
  let(:enemy) { Factory :enemy }
  let(:sword) { Factory :belonging, item: Factory(:sword_item, speed: -1, add_dex: 1), character: character}
  let(:armor) { Factory :belonging, item: Factory(:armor_item, add_vit: 1), character: character}
  before do
    sword.equip
    armor.equip
    enemy.level = 1
  end

  context '能力値が装備品の修正を受けていること' do
    it { character.total_dex.should eq 7 }
    it { character.total_vit.should eq 7 }
    context 'Enemyであれば修正値は受けないこと' do
      it { enemy.total_vit.should eq enemy.vit }
    end
    context '能力値がメモ化されていること' do
      before do
        character.total_dex
        character.equip.weapon = nil
      end
      it { character.total_dex.should eq 7 }
    end
  end

  context 'HP最大値を整数として得られること' do
    it { character.max_hp.should be_integer }
    it { enemy.max_hp.should be_integer }
  end
  context 'MP最大値を整数として得られること' do
    it { character.max_mp.should be_integer }
    it { enemy.max_mp.should be_integer }
  end

  context '武器攻撃時のスピードを整数として得られること' do
    it { character.attack_speed_with_weapon.should be_integer }
    it { enemy.attack_speed_with_weapon.should be_integer }
  end

  context '魔法攻撃時のスピードを整数として得られること' do
    it { character.attack_speed_with_magic.should be_integer }
    it { enemy.attack_speed_with_magic.should be_integer }
  end

  context 'スピード値が整数として得られること' do
    it { character.speed.should be_integer }
    it { enemy.speed.should be_integer }
  end

  context '武器のアイテムタイプを得られること' do
    it { character.weapon_item_type.should eq 'sword' }
    it { enemy.weapon_item_type.should be_nil }
    context 'なにも装備していないときは拳属性になること' do
      before do
        character.equip.weapon = nil
      end
      it { character.weapon_item_type.should eq 'fist' }
    end
  end
end
