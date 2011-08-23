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
    if category == 'weapon' && self.item.two_handed?
      self.character.equip.shield = nil
    elsif category == 'shield' && self.character.equip.weapon && self.character.equip.weapon.item.two_handed?
      self.character.equip.weapon = nil
    end
    self.character.equip.send category + '=', self
  end

  def remove(num = 1)
    raise RuntimeError, "Expected argument <= #{self.num}. Got#{num}" if self.num < num
    self.num -= num
    if self.num == 0
      self.delete
    end
  end

end
