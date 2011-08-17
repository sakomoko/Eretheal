class ItemType
  include Mongoid::Document
  field :key, :type => String
  field :name, :type => String
  field :range, :type => Integer

  belongs_to :attribute, index: true
end
