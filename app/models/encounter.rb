class Encounter
  include Mongoid::Document

  belongs_to :field

  field :probability, type: Integer, default: 0
end
