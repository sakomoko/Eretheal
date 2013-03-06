class Field
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering

  belongs_to :link, :class_name => 'Field', :inverse_of => nil

  field :name, :type => String
  field :no_image, :type => Boolean, :default => true
  field :distance, :type => Integer, :default => 0

  def routes
    children + [link, parent.root? ? nil : parent ].compact
  end

  class << self
    def create_seed
      delete_all
      fields = YAML.load_file "#{Rails.root}/db/seeds/fields.yml"
      create_children fields
    end

    def create_children(fields, parent = nil)
      fields.each do |field|
        children = nil
        if field.key? "children"
          children = field["children"]
          field.delete "children"
        end
        field[:parent] = parent if parent
        m = Field.new field
        m.id = field["id"]
        m.link_id = field["link"] if field["link"]
        m.save!
        create_children children, field["id"] if children
      end
    end
  end
end
