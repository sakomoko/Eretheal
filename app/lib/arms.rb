module Arms
  extend ActiveSupport::Memoizable

  attr_reader :action
  attr_accessor :formula

  def initialize
    super
    @formula = Eretheal::Formula.new
  end

  def max_hp
    formula.max_hp self
  end

  def max_mp
    formula.max_mp self
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
        return self.equip.weapon.item.item_type.key
      end
      return 'fist'
    end
  end

  def action=(action)
    raise unless action.is_a? Action
    @action = action
  end

  [:total_dex, :total_agi, :total_int, :total_vit, :total_str, :total_mnd].each do |key|
    status = key.to_s.slice(6,3)
    define_method(key) do
      bonus = 0
      if self.respond_to? :equip
        self.equip.each do |key, b|
          bonus += b.item.send("add_" << status)
        end
      end
       self.send(status) + bonus
    end
    memoize key
  end
end
