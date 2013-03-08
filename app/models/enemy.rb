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

  field :gender
  enumerize :gender, in: [:male, :female], default: :male, predicates: true

  attr_accessor :level

  validates_uniqueness_of :key
  validates_presence_of :key

  attr_accessible :key, :name, :base_hp, :base_mp, :dex_up, :agi_up, :str_up, :vit_up, :int_up, :mnd_up, as: [:default, :seeder]
  attr_accessible :dmg, :def, :magi, :magi_def, :hit, :avoid, :speed, :guard, :counter, :exp, :color, as: [:default, :seeder]
  attr_accessible :explain, :range, :publicity, :gender, as: [:default, :seeder]
end
