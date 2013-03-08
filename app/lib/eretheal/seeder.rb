module Eretheal
  module Seeder
    extend ActiveSupport::Concern

    module ClassMethods
      def seeder_path
        Rails.root.to_s + (Rails.env.test? ? '/spec/fixtures' : '/db/seeds')
      end

      def create_seed
        delete_all
        documents = YAML.load_file "#{seeder_path}/#{name.tableize}.yml"
        models = []
        documents.each do |params|
          models << create!(params, as: :seeder) do |base_model|
            base_model.id = params["_id"] if params["_id"]
            create_relation base_model, relations, params
          end
        end
      end


      # Create relations.
      #
      # @param [ Document, metadata, Hash ]
      def create_relation(base_model, relations, params)
        return if relations.empty?

        relations.each do |key, relation|
          next unless params.key? key

          case relation.macro
          when :embeds_many
            create_many_reference(base_model, relation, params[key])
          when :belongs_to

            relation_model = relation.polymorphic? ? params[key + "_type"].camelize.constantize : relation.klass
            create_reference(base_model, relation, relation_model, params[key])
          else
            raise 'relation type error: ' + relation.macro.to_s
          end
        end
      end

      # Create hasMany, embedsMany relations.
      #
      def create_many_reference(base_model, metadata, document)
        document.each do |doc|
          r = base_model.send metadata.name
          r << metadata.klass.new(doc, as: :seeder) do |m|
            create_relation(m, m.relations, doc)
          end
          base_model.save!
        end
      end

      # Create embedsOne, belongsTo relations.
      def create_reference(base_model, relation, relation_model, params)
        base_model.send relation.setter, relation_model.find(params["_id"] || params["key"])
      end
    end
  end
end
