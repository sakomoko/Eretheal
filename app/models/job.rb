class Job
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  include Eretheal::Seeder

  field :name, :type => String
  field :name_jp, :type => String

  field :add_dex, :type => Float, :default => 1
  field :add_agi, :type => Float, :default => 1
  field :add_str, :type => Float, :default => 1
  field :add_int, :type => Float, :default => 1
  field :add_vit, :type => Float, :default => 1
  field :add_mnd, :type => Float, :default => 1

  field :dex_up, :type => Integer, :default => 0
  field :agi_up, :type => Integer, :default => 0
  field :str_up, :type => Integer, :default => 0
  field :int_up, :type => Integer, :default => 0
  field :vit_up, :type => Integer, :default => 0
  field :mnd_up, :type => Integer, :default => 0

  attr_accessible :name, :name_jp, :add_dex, :add_agi, :add_str, :add_int, :add_vit, :add_mnd, as: [:default, :seeder]
  attr_accessible :dex_up, :agi_up, :str_up, :int_up, :vit_up, :mnd_up, as: [:default, :seeder]
end
