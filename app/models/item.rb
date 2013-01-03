class Item
  include Mongoid::Document
  include Mongoid::Paranoia

  belongs_to :item_type
  embeds_one :status_adjustment
  embeds_one :status_coefficient

  accepts_nested_attributes_for :status_adjustment, :status_coefficient

  field :name, :type => String
  field :power, :type => Integer, :default => 0
  field :speed, :type => Integer, :default => 0
  field :weight, :type => Integer, :default => 0
  field :color, :type => String

  field :two_handed, :type => Boolean, :default => 0

  field :explain, :type => String
  field :critical, :type => Integer, :default => 0

  field :stack, :type => Boolean, :default => 1
  field :price, :type => Integer, :default => 0

  field :demand, :type => Integer, :default => 5

end
