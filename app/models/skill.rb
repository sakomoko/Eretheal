class Skill
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps


  embeds_one :status_adjustment
  embeds_one :status_coefficient

  accepts_nested_attributes_for :status_adjustment, :status_coefficient

  field :key, :type => String
  field :name, :type => String
  field :cost, :type => Integer, :default => 0
  field :explain, :type => String

end
