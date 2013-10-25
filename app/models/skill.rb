class Skill
  include Mongoid::Document
  include Eretheal::Seeder

  embeds_one :status_adjustment
  embeds_one :status_coefficient

  accepts_nested_attributes_for :status_adjustment, :status_coefficient

  field :_id, type: String, default: -> { key }
  field :key, :type => Symbol
  field :name, :type => String
  field :cost, :type => Integer, :default => 0
  field :description, :type => String

end
