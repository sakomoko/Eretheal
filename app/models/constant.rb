class Constant
  include Mongoid::Document
  include Mongoid::Slug
  include Eretheal::Seeder

  field :key, type: String
  field :body, type: String, default: nil
  slug :key

  belongs_to :constable, polymorphic: true, inverse_of: :constant
end
