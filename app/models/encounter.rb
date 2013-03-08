class Encounter
  include Mongoid::Document
  include Eretheal::Seeder

  belongs_to :field
  belongs_to :enemy_group

  field :probability, type: Integer, default: 0

  attr_accessible :probability, :field_id, :enemy_group_id, as: [:default, :seeder]
end
