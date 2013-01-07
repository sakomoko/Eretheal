class WeaponType
  include Mongoid::Document
  include Mongoid::Slug

  field :key, type: String
  field :name, type: String
  field :range, type: Integer, default: 0

  belongs_to :attribute, index: true
end
