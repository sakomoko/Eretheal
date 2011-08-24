module Arms

  def max_hp
    ((self.total_vit * 3) + (self.level * 3) + (1.015 ** self.level)).to_i
  end

  def max_mp
    ((self.total_mnd * 3) + (self.level * 3) + (1.015 ** self.level)).to_i
  end

  def attack_speed_with_weapon
    speed = 0
    if self.class.to_s.downcase.to_sym.in?([:character]) && self.equip.weapon
      speed += self.equip.weapon.item.speed
    end
    self.speed + speed
  end

  def attack_speed_with_magic
    ((self.total_int + (10 / self.total_int)) * 0.4).to_i
  end

  def speed
    ((self.total_agi + (10 / self.total_agi)) * 0.4).to_i
  end

  def weapon_item_type
    if self.respond_to? :equip
      if self.equip.weapon
        return self.equip.weapon.item.item_type.key
      end
      return 'fist'
    end
  end

  [:total_dex, :total_agi, :total_int, :total_vit, :total_str, :total_mnd].each do |key|
    status = key.to_s.slice(6,3)
    define_method(key) do
      result = self.instance_variable_get("@"+key.to_s)
      return result if result
      bonus = 0
      if self.respond_to? :equip
        self.equip.each do |key, b|
          bonus += b.item.send("add_" << status)
        end
      end
      self.instance_variable_set("@"+key.to_s, self.send(status) + bonus)
    end
  end
end
