class EnemyGroup
  include Mongoid::Document
  include Mongoid::Slug
  include Eretheal::Seeder

  embeds_many :enemy_sets
  belongs_to :field

  field :key, type: String
  slug :key

  accepts_nested_attributes_for :enemy_sets

  attr_accessible :key, :enemy_sets, :field_id, as: :default
  attr_accessible :key, as: :seeder
end
