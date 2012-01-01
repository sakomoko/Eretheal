class Position
  include Mongoid::Document

  embedded_in :character
  belongs_to :field, index: true
  belongs_to :destination, class_name: 'Field', index: true

  field :distance, type: Integer, default: 0

  def area
    self.field.root
  end

  def renew(field)
    self.distance = 0
    if field.root?
      self.field = field.children.first
    elsif field.link
      self.field = field.link.children.first
    else
      self.field = field
    end
  end

end
