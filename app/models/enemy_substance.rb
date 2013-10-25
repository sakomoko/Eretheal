class EnemySubstance
  include Mongoid::Document
  include Eretheal::CombatActor

  embedded_in :action_report
  belongs_to :body, class_name: '::Enemy'

  field :level, type: Integer, default: 1
  field :hp, type: Integer, default: 0
  field :mp, type: Integer, default: 0
  field :charge_time, type: Integer, default: 0

  delegate *(Enemy.attribute_names - [:_id, :_slugs]), to: :body

  after_initialize do |document|
    set_up
  end

end
