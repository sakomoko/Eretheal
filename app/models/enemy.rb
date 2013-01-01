class Enemy
  include Mongoid::Document
  include Eretheal::CombatActor

  field :name, type: String
  field :development_type, type: String

  field :default_hp, type: Integer, default: 0
  field :default_mp, type: Integer, default: 0

  field :dex, type: Integer, default: 0
  field :agi, type: Integer, default: 0
  field :str, type: Integer, default: 0
  field :vit, type: Integer, default: 0
  field :int, type: Integer, default: 0
  field :mnd, type: Integer, default: 0

  field :dmg, type: Integer, default: 0
  field :def, type: Integer, default: 0
  field :magi, type: Integer, default: 0
  field :magi_def, type: Integer, default: 0
  field :hit, type: Integer, default: 0
  field :avoid, type: Integer, default: 0

  field :speed, type: Integer, default: 0
  field :guard, type: Integer, default: 0
  field :critical, type: Integer, default: 0
  field :critical_def, type: Integer, default: 0
  field :counter, type: Integer, default: 0

  field :exp, type: Integer, default: 0
  field :color, type: String, default: '#ffffff'

  field :explain, type: String

  field :range, type: Integer, default: 2
  field :publicity, type: Integer, default: 0

  attr_accessor :level

  after_initialize :set_up

end
