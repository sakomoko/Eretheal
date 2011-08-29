class Skill
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  include Action

  embeds_one :status_adjustment
  embeds_one :status_coefficient

  belongs_to :system_message, index: true

  field :name, :type => String
  field :key, :type => String

  field :power, :type => Integer, :default => 0

  field :use_hp, :type => Integer, :default => 0
  field :use_mp, :type => Integer, :default => 0

  field :speed, :type => Integer, :default => 0
  field :delay, :type => Integer, :default => 0

  field :active, :type => Boolean, :default => true
  field :range, :type => Integer, :default => 0

  field :color, :type => String, :default => '#ffffff'
  field :cost, :type => Integer, :default => 0
  field :spell, :type => Boolean, :default => false
  field :critical, :type => Integer, :default => 0
  field :explain, :type => String
end
