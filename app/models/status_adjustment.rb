class StatusAdjustment
  include Mongoid::Document

  field :dmg, :type => Integer, :default => 0
  field :defence, :type => Integer, :default => 0
  field :hit, :type => Integer, :default => 0
  field :avoid, :type => Integer, :default => 0
  field :magi, :type => Integer, :default => 0
  field :magi_defence, :type => Integer, :default => 0

  field :dex, :type => Integer, :default => 0
  field :agi, :type => Integer, :default => 0
  field :int, :type => Integer, :default => 0
  field :vit, :type => Integer, :default => 0
  field :str, :type => Integer, :default => 0
  field :mnd, :type => Integer, :default => 0

  field :hp, :type => Integer, :default => 0
  field :mp, :type => Integer, :default => 0
end
