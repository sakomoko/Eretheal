module Eretheal
  module Seeder
    def self.included(base)
      base.extend self
    end

    def create_seed
      delete_all
      blocks = {}

      unless relations.empty?
        relations.each do |key, relation|
          blocks[key] = ->(model, document) do
            relation_model = Object.const_defined?(relation.class_name) ? relation.class_name.constantize : document[relation.name.to_s + "_type"].camelize.constantize
            model.send relation.setter, relation_model.find(document[key]["_id"] || document[key]["key"])
          end
        end
      end

      documents = YAML.load_file "#{Rails.root}/db/seeds/#{name.tableize}.yml"
      documents.each do |doc|
        create! doc do |d|
          d.id = doc["_id"] if doc["_id"]
          blocks.each_value { |block| block.call(d, doc) }
        end
      end
    end
  end
end
