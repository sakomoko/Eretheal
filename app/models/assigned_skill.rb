class AssignedSkill
  include Mongoid::Document

  embedded_in :character
  belongs_to :skill

  field :set_number, :type => Integer, :default => 0
  field :sort, :type => Integer, :default => 0
end
