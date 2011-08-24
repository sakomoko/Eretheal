class Item
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  belongs_to :item_type

  field :name, :type => String
  field :power, :type => Integer, :default => 0
  field :speed, :type => Integer, :default => 0
  field :weight, :type => Integer, :default => 0
  field :color, :type => String
  field :hit, :type => Integer, :default => 0
  field :avoid, :type => Integer, :default => 0
  field :magi, :type => Integer, :default => 0
  field :magi_def, :type => Integer, :default => 0

  field :add_dex, :type => Integer, :default => 0
  field :add_agi, :type => Integer, :default => 0
  field :add_vit, :type => Integer, :default => 0
  field :add_str, :type => Integer, :default => 0
  field :add_int, :type => Integer, :default => 0
  field :add_mnd, :type => Integer, :default => 0

  field :add_hp, :type => Integer, :default => 0
  field :add_hp, :type => Integer, :default => 0

  field :two_handed, :type => Boolean, :default => 0

  field :explain, :type => String
  field :critical, :type => Integer, :default => 0

  field :stack, :type => Boolean, :default => 1
  field :price, :type => Integer, :default => 0

  field :demand, :type => Integer, :default => 5


end
