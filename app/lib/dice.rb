class Dice
  class << self
    def roll(type)
      raise unless /^(\d+)d(\d+)/ =~ type
      num, type = $1.to_i, $2.to_i
      result = 0
      num.times do
        result += Random.rand(type) + 1
      end
      result
    end
  end
end
