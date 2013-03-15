module Eretheal
  class Formula

    def max_hp(vit, level)
      max_point(vit, level)
    end

    def max_mp(mnd, level)
      max_point(mnd, level)
    end

    def max_point(parameter, level)
      (((parameter * 3) + (level * 3)).to_f * (1.015 ** level)).to_i
    end

    def parameter(level, growth_rate)
      (growth_rate.to_f / 10 * level + (growth_rate.to_f / 6)).truncate
    end

    def speed(parameter)
      return 2 if parameter <= 6
      param = parameter.to_f / 3
      ((param + (10.0 / param)) * 0.4).truncate
    end

  end
end
