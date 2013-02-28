class Position
  include Mongoid::Document
  extend Forwardable
  def_delegators(:field, :name, :no_image?)

  embedded_in :character
  belongs_to :field, index: true
  belongs_to :destination, class_name: 'Field', index: true

  field :distance, type: Integer, default: 0

  before_create do |document|
    document.field = Constant.find("default-position").constable unless document.field
  end

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

  def serializable_hash(options=nil)
    options ||= {}
    super(options.reverse_merge({ :include => :field, :methods => :area }))
  end

end
