# -*- coding: utf-8 -*-
describe Eretheal::CombatActor do
  let(:character) { FactoryGirl.create :character, equip: FactoryGirl.create(:equip) }
  let(:enemy) { FactoryGirl.build :enemy_substance }
  let(:sword) { FactoryGirl.create :inventory_item, item: FactoryGirl.create(:sword_item, speed: -1, status_adjustment: FactoryGirl.create(:status_adjustment, dex: 1)), character: character}
  let(:armor) { FactoryGirl.create :inventory_item, item: FactoryGirl.create(:armor_item, status_adjustment: FactoryGirl.create(:status_adjustment, vit: 1)), character: character}
  before do
    sword.equip
    armor.equip
  end

  describe '.clean' do
    before do
      character.clean
    end
    it 'HPが最大値になること' do
      character.hp.should eq character.max_hp
    end
    it 'MPが最大値になること' do
      character.mp.should eq character.max_mp
    end
  end

  context '能力値が装備品の修正を受けていること' do
    it { character.total_dex.should eq 6 }
    it { character.total_vit.should eq 7 }
    context 'Enemyであれば修正値は受けないこと' do
      it { enemy.total_vit.should eq enemy.vit }
    end
    pending 'メモ化するかどうか策定中' do
    context '能力値がメモ化されていること' do
      before do
        character.total_dex
        character.equip.weapon = nil
      end
      it { character.total_dex.should eq 7 }
    end
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

  context 'Actionをセットできること' do
    pending '仕様が決まらないので中断' do
    let(:skill) { FactoryGirl.create :skill }
    before do
      character.assigned_skills << FactoryGirl.create(:assigned_skill, skill: skill)
      character.action = skill
      enemy.action = skill
    end
    it { character.action.should eq skill }
    it { enemy.action.should eq skill}
    context 'Actionではないものをセットしたとき' do
      it '例外が発生すること' do
        expect { character.action = FactoryGirl.create :item }.to raise_error
      end
    end
    end
  end

  describe '.current?' do
    it '常にfalseを返す' do
      enemy.should_not be_current
    end
  end
end
