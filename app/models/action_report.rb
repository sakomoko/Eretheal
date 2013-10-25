class ActionReport
  include Mongoid::Document

  embedded_in :character
  embeds_many :enemies, class_name: 'EnemySubstance'

  def enemy_group=(group)
    group.enemy_sets.each do |set|
      set.num.times do
        enemy_substance = EnemySubstance.new(level: set.level, body: set.enemy)
        enemy_substance.clean
        enemies << enemy_substance
      end
    end
  end

  def to_a
    actors = []
    actors << character
    enemies.each do |enemy|
      actors << enemy
    end
    actors
  end

end
