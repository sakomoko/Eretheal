class Attribute
  include Mongoid::Document
  include Mongoid::Slug
  field :name, :type => String
  field :key, :type => String

  slug :key
end
