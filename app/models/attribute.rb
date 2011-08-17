class Attribute
  include Mongoid::Document
  field :name, :type => String
  field :key, :type => String

  has_many :item_types
end
