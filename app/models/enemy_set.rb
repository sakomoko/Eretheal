class EnemySet
  include Mongoid::Document

  embedded_in :enemy_group
  belongs_to :enemy

  field :level, type: Integer, default: 1
  field :num, type: Integer, default: 1
end
