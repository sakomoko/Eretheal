module Eretheal
  class Formula

    [:hp, :mp].each do |type|
      define_method("max_#{type.to_s}") do |arms|
        case type
        when :hp
          status = "vit"
        when :mp
          status = "mnd"
        end
        ((arms.send("total_#{status}") * 3) + (arms.level * 3) + (1.015 ** arms.level)).to_i
      end
    end

    def speed(parameter)
      return 1 if parameter < 1
      ((parameter + (10 / parameter)) * 0.4).to_i
    end

  end
end
