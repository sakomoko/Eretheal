class Field
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering

  belongs_to :link, :class_name => 'Field'

  field :name, :type => String
  field :no_image, :type => Boolean, :default => true
  field :distance, :type => Integer, :default => 0
end
