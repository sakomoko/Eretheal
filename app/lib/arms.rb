module Arms

  def max_hp
    ((self.vit * 3) + (self.level * 3) + (1.015 ** self.level)).to_i
  end

  def max_mp
    ((self.mnd * 3) + (self.level * 3) + (1.015 ** self.level)).to_i
  end

end
