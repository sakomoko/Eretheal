class Candy
  include Mongoid::Document

  field :red, :type => Integer, default: 0
  field :blue, :type => Integer, default: 0
  field :green, :type => Integer, default: 0
  field :yellow, :type => Integer, default: 0
  embedded_in :character, :inverse_of => :candies
end
