class WeaponType
  include Mongoid::Document
  include Mongoid::Slug
  include Eretheal::Seeder

  field :key, type: String
  field :name, type: String
  field :range, type: Integer, default: 0

  belongs_to :attribute, index: true

  slug :key

  attr_accessible :key, :name, :range, as: [:default, :seeder]
  attr_accessible :attribute_id, as: :default
end
