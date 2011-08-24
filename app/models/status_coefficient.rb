class StatusCoefficient
  include Mongoid::Document

  embedded_in :skill

  field :dex, :type => Float
  field :agi, :type => Float
  field :int, :type => Float
  field :vit, :type => Float
  field :str, :type => Float
  field :mnd, :type => Float
end
