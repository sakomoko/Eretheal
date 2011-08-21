class Item
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  embeds_one :item_type

  field :name, :type => String
  field :power, :type => Integer
  field :speed, :type => Integer
  field :weight, :type => Integer
  field :color, :type => String
  field :hit, :type => Integer
  field :avoid, :type => Integer
  field :magi, :type => Integer
  field :magi_def, :type => Integer

  field :add_dex, :type => Integer
  field :add_agi, :type => Integer
  field :add_vit, :type => Integer
  field :add_str, :type => Integer
  field :add_int, :type => Integer
  field :add_mnd, :type => Integer

  field :add_hp, :type => Integer
  field :add_hp, :type => Integer

  field :two_handed, :type => Boolean

  field :explain, :type => String
  field :critical, :type => Integer

  field :is_stack, :type => Boolean, :default => 1
  field :price, :type => Integer

  field :demand, :type => Integer, :default => 5

  def stacks?
    self.is_stack
  end

end
