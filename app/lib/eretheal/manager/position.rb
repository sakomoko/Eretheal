module Eretheal
  module Manager
    class Position
      extend Forwardable
      def_delegators :base, :pc, :add_message, :select_decision
      attr_reader :base

      def initialize(base)
        @base = base
      end

      def go(id)
        field = ::Field.find id
        raise 'Position Error.' unless field.in? pc.position.routes
        pc.position.renew field
        add_message 'arrival', name: pc.position.name
        encount! if encount?
      end

      def encount?
        Random.rand(100) < pc.position.encount_probability
      end

      def encount!
        encounters = pc.position.field.encounters
        encount = select_decision encounters
        report = ActionReport.new
        report.enemy_group = encount.enemy_group
        pc.action_report = report
        add_message 'encount-enemy'
      end

    end
  end
end
