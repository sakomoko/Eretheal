class InventoryItem
  include Mongoid::Document
  include Mongoid::Timestamps


  embedded_in :character
  belongs_to :item, index: true

  field :durability, :type => Integer, :default => 0
  field :color, :type => String
  field :num, :type => Integer, :default => 0
  field :sort, :type => Integer, :default => 0

  def equip
    return false unless self.item.equip?
    category = self.item.equip_category.key
    if category == 'weapon' && self.item.two_handed?
      self.character.equip.shield = nil
    elsif category == 'shield' && self.character.equip.weapon && self.character.equip.weapon.item.two_handed?
      self.character.equip.weapon = nil
    end
    self.character.equip.send category + '=', self
  end

  def unequip
    return false if !self.item.equip? || !self.equipping?
    category = self.item.equip_category.key
    self.character.equip.send category + '=', nil
    true
  end

  def remove(num = 1)
    raise RuntimeError, "Expected argument <= #{self.num}. Got#{num}" if self.num < num
    return false if self.equipping?
    self.num -= num
    if self.num == 0
      self.character.inventory.removed = self.id
      self.delete
    end
  end

  def equipping?
    return false unless item.equip?
    equip = self.character.equip
    category = self.item.equip_category.key
    if equip.respond_to? category
      equipping = equip.send(category)
      return true if equipping && equipping.id == self.id
    end
    false
  end

  def method_missing(method, *args)
    item.send method, *args
  end

end
