module Eretheal
  module Manager
    class Base

      attr_reader :pc, :position, :messages

      def initialize(character)
        @pc = character
        @position = Manager::Position.new self
        @messages = []
      end

      def add_message(key, params)
        msg = ::Message.find key
        @messages.push(msg.body % params)
      end

      def finish
        pc.save! if pc.changed?
      end
    end
  end
end
