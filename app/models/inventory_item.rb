class InventoryItem
  include Mongoid::Document
  include Mongoid::Timestamps

  include Action

  embedded_in :character
  belongs_to :item, index: true

  field :durability, :type => Integer, :default => 0
  field :color, :type => String
  field :num, :type => Integer, :default => 0
  field :sort, :type => Integer, :default => 0

  def equip
    return false unless self.item.item_type.equip_category.equip?
    category = self.item.item_type.equip_category.key
    if category == 'weapon' && self.item.two_handed?
      self.character.equip.shield = nil
    elsif category == 'shield' && self.character.equip.weapon && self.character.equip.weapon.item.two_handed?
      self.character.equip.weapon = nil
    end
    self.character.unmemoize_all
    self.character.equip.send category + '=', self
  end

  def unequip
    return false if !self.item.item_type.equip_category.equip? || !self.equipping?
    category = self.item.item_type.equip_category.key
    self.character.equip.send category + '=', nil
    self.character.unmemoize_all
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
    equip = self.character.equip
    category = self.item.item_type.equip_category.key
    if equip.respond_to? category
      equipping = equip.send(category)
      return true if equipping && equipping.id == self.id
    end
    false
  end

end
