class StatusCoefficient
  include Mongoid::Document

  field :dex, :type => Float, :default => 1
  field :agi, :type => Float, :default => 1
  field :int, :type => Float, :default => 1
  field :vit, :type => Float, :default => 1
  field :str, :type => Float, :default => 1
  field :mnd, :type => Float, :default => 1
end
