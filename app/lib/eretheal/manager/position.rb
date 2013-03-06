module Eretheal
  module Manager
    class Position
      extend Forwardable
      def_delegators :base, :pc, :add_message
      attr_reader :base

      def initialize(base)
        @base = base
      end

      def go(id)
        field = ::Field.find id
        raise 'Position Error.' unless field.in? pc.position.routes
        pc.position.renew field
        add_message 'arrival', name: pc.position.name
      end

    end
  end
end
