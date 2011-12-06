module Eretheal
  module Formula
    class << self
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
    end
  end
end
