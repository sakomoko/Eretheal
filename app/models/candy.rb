class Candy
  include Mongoid::Document
  field :red, :type => Integer
  field :blue, :type => Integer
  field :green, :type => Integer
  field :yellow, :type => Integer
  embedded_in :character, :inverse_of => :candies
end
