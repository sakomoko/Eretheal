class Constant
  include Mongoid::Document
  include Mongoid::Slug
  include Eretheal::Seeder

  field :key, type: String
  field :body, type: String, default: nil
  slug :key

  belongs_to :constable, polymorphic: true, inverse_of: :constant

  attr_accessible :key, :body, :constable_id, as: [:default, :seeder]

  rails_admin do
    list do
      field :key
      field :body
      field :constable
    end
  end
end
