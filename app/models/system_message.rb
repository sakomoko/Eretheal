class SystemMessage
  include Mongoid::Document

  field :key, :type => String
  field :message, :type => String
  field :level, :type => Integer, :default => 1
  field :class, :type => String

end
