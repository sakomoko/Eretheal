class Procedure
  include Mongoid::Document
  embedded_in :actor, polymorphic: true

  belongs_to :command, class_name: 'ProcedureCommand'
  belongs_to :action, class_name: 'ActiveSkill'

  field :sort, type: Integer
  field :value, type: Integer

  attr_accessor :performer
  attr_reader :target

  def call(actors)
    if send(command.key, actors)
      return true unless action.no_use? target
    end
    false
  end

  def low_hp_enemy(actors)
    enemies = actors.select {|item| item.group != performer.group}
    @target = enemies.min_by(&:hp)
  end

  def low_hp_friend(actors)
    @target = (actors.select { |item| item.group == performer.group }).min_by(&:hp)
  end

end
