class ActiveSkill < Skill

  belongs_to :message, index: true

  field :power, :type => Integer, :default => 0

  field :use_hp, :type => Integer, :default => 0
  field :use_mp, :type => Integer, :default => 0

  field :speed, :type => Integer, :default => 0
  field :delay, :type => Integer, :default => 0

  field :range, :type => Integer, :default => 0

  field :spell, :type => Boolean, :default => false
  field :critical, :type => Integer, :default => 0
end
