class EquipCategory
  include Mongoid::Document
  include Mongoid::Slug

  field :key, type: String
  field :name, type: String
  field :equip, type: Boolean, default: 1

  slug :key
end
