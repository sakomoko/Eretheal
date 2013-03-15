class EnemySubstance
  include Mongoid::Document

  embedded_in :action_report
  belongs_to :body, class_name: '::Enemy'

  field :level, type: Integer, default: 1
  field :hp, type: Integer, default: 0
  field :mp, type: Integer, default: 0
  field :charge_time, type: Integer, default: 0

  def convert
    body.substance = self
    body
  end
end
