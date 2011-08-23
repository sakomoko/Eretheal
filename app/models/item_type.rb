class ItemType
  include Mongoid::Document
  field :key, :type => String
  field :name, :type => String
  field :category, :type => String
  field :range, :type => Integer, :default => 0
  field :equip, :type => Boolean, :default => false

  belongs_to :attribute, index: true
end
