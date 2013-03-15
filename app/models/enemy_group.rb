class EnemyGroup
  include Mongoid::Document
  include Mongoid::Slug
  include Eretheal::Seeder

  embeds_many :enemy_sets

  field :key, type: String
  slug :key

  accepts_nested_attributes_for :enemy_sets

  attr_accessible :key, :enemy_sets, as: :default
  attr_accessible :key, as: :seeder
end
