class Field
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering

  belongs_to :link, :class_name => 'Field'

  field :name, :type => String
  field :no_image, :type => Boolean
  field :distance, :type => Integer
end