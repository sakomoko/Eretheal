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
end
