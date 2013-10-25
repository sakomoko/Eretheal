module Eretheal
  module CombatActor
    extend ActiveSupport::Concern

    included do
      belongs_to :action, class_name: '::ActiveSkill'
      belongs_to :target, polymorphic: true
    end

    def clean
      self.hp = max_hp
      self.mp = max_mp
      self
    end

    def formula
      @formula ||= Eretheal::Formula.new
    end

    def set_up
    end

    def max_hp
      formula.max_hp(vit, level)
    end

    def max_mp
      formula.max_mp(mnd, level)
    end

    def action_speed
      speed
    end

    def attack_speed_with_weapon
      speed = 0
      if self.class.to_s.downcase.to_sym.in?([:character]) && self.equip.weapon
        speed += self.equip.weapon.item.speed
      end
      self.speed + speed
    end

    def attack_speed_with_magic
      formula.speed self.total_int
    end

    def speed
      formula.speed self.total_agi
    end

    def weapon_item_type
      if self.respond_to? :equip
        if self.equip.weapon
          return self.equip.weapon.item.weapon_type.key
        end
        return 'fist'
      end
    end

    def current?
      false
    end

    [:dex, :agi, :int, :vit, :str, :mnd].each do |key|
      define_method(key) do
        if respond_to?(:job)
          formula.parameter(level, job.send("#{key.to_s}_up"))
        else
          formula.parameter(level, send("#{key.to_s}_up"))
        end
      end
    end

    [:total_dex, :total_agi, :total_int, :total_vit, :total_str, :total_mnd].each do |key|
      status = key.to_s.slice(6,3)
      define_method(key) do
        bonus = 0
        if self.respond_to? :equip
          self.equip.each do |key, b|
            if b.item.status_adjustment
              bonus += b.item.status_adjustment.send(status)
            end
          end
        end
        self.send(status) + bonus
      end
    end

    def set_action!(actors)
      procedures.each do |procedure|
        procedure.performer = self
        if procedure.call(actors)
          self.action = procedure.action
          self.target = procedure.target
          return
        end
      end
      raise 'procedure error.'
    end

    def group
      :enemy
    end
  end
end
