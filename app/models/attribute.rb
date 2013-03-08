class Attribute
  include Mongoid::Document
  include Mongoid::Slug
  include Eretheal::Seeder
  field :name, :type => String
  field :key, :type => String

  slug :key
  attr_accessible :key, :name, as: [:default, :seeder]
end
