class Job
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

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
end
