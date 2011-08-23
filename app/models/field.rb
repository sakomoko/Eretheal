class Field
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering

  field :name, :type => String
  field :no_image, :type => Boolean
end
