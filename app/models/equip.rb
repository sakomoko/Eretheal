class Equip
  include Mongoid::Document
  embedded_in :character
  belongs_to :weapon, class_name: 'Belonging'
  belongs_to :shield, class_name: 'Belonging'
  belongs_to :head,   class_name: 'Belonging'
  belongs_to :armor,  class_name: 'Belonging'
  belongs_to :groob,  class_name: 'Belonging'
  belongs_to :boots,  class_name: 'Belonging'
  belongs_to :accessory, class_name: 'Belonging'
  belongs_to :arrow,  class_name: 'Belonging'

  def each
    @equips ||= [:weapon, :shield, :head, :armor, :groob, :boots, :accessory, :arrow]
    @equips.each do |key|
      result = self.send key
      next unless result
      yield key, self.send(key)
    end
  end
end

