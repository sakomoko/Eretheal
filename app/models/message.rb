class Message
  include Mongoid::Document
  include Mongoid::Slug

  field :key, type: String
  field :body, type: String
  field :level, type: Integer, default: 1

  slug :key

  validates_uniqueness_of :key
  validates_presence_of :key
end
