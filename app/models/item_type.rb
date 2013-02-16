class ItemType
  include Mongoid::Document
  include Mongoid::Slug
  include Eretheal::Seeder

  field :key, :type => String
  field :name, :type => String
  slug :key

end
