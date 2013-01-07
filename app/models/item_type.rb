class ItemType
  include Mongoid::Document
  include Mongoid::Slug

  field :key, :type => String
  field :name, :type => String
  slug :key

end
