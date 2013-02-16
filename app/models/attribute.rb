class Attribute
  include Mongoid::Document
  include Mongoid::Slug
  include Eretheal::Seeder
  field :name, :type => String
  field :key, :type => String

  slug :key
end
