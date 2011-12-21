# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

module Eretheal
  module Seed
    module Field
      class << self
        def create(fields, parent = nil)
          fields.each do |field|
            childrens = nil
            if field.key? "children"
              childrens = field["children"]
              field.delete "children"
            end
            field[:parent] = parent if parent
            m = ::Field.new field
            m.id = field["id"]
            m.save!
            create childrens, field["id"] if childrens
          end
        end
      end
    end
  end
end

fields = YAML.load_file "#{Rails.root}/db/seeds/fields.yml"
Field.delete_all
Eretheal::Seed::Field.create fields

jobs = YAML.load_file "#{Rails.root}/db/seeds/jobs.yml"
Job.delete_all
jobs.each do |job|
  m = ::Job.new job
  m.save!
end
