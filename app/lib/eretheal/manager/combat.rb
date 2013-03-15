module Eretheal
  module Manager
    class Combat
      delegate :pc, :add_message, to: :base

      def initialize(base)
        @base = base
      end

      def run
        @actors = pc.action_report.to_a
      end

    end
  end
end
