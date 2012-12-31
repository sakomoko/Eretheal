class Equip
  include Mongoid::Document
  embedded_in :character
  belongs_to :weapon, class_name: 'InventoryItem'
  belongs_to :shield, class_name: 'InventoryItem'
  belongs_to :head,   class_name: 'InventoryItem'
  belongs_to :armor,  class_name: 'InventoryItem'
  belongs_to :groob,  class_name: 'InventoryItem'
  belongs_to :boots,  class_name: 'InventoryItem'
  belongs_to :accessory, class_name: 'InventoryItem'
  belongs_to :arrow,  class_name: 'InventoryItem'

  def each
    @equips ||= [:weapon, :shield, :head, :armor, :groob, :boots, :accessory, :arrow]
    @equips.each do |key|
      result = self.send key
      next unless result
      yield key, self.send(key)
    end
  end
end

