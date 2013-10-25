class ProcedureCommand
  include Mongoid::Document
  extend Enumerize
  include Eretheal::Seeder

  field :_id, type: String, default: -> { key }
  field :key, type: Symbol
  field :name, type: String
  field :target, type: Symbol
  enumerize :target, in: [:enemy, :friend, :self], default: :enemy

  attr_accessible :key, :name, :target, as: [:default, :seeder]
end
