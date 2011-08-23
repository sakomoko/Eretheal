class Belonging
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :character
  belongs_to :item, index: true

  field :durability, :type => Integer, :default => 0
  field :color, :type => String
  field :num, :type => Integer, :default => 0
  field :sort, :type => Integer, :default => 0

  def equip
    return false unless self.item.item_type.equip?
    category = self.item.item_type.category
    self.character.equip.send category + '=', self
  end

end
