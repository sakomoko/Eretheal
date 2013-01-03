class ItemType
  include Mongoid::Document
  include Mongoid::Slug

  field :key, :type => String
  field :name, :type => String
  field :range, :type => Integer, :default => 0
  slug :key

  belongs_to :equip_category, index: true
  belongs_to :attribute, index: true
end
