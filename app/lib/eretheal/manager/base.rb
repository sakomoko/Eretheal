module Eretheal
  module Manager
    class Base

      attr_reader :pc, :position, :messages

      def initialize(character)
        @pc = character
        @pc.set_current!
        @position = Manager::Position.new self
        @messages = []
      end

      def add_message(key, params = {})
        msg = ::Message.find key
        @messages.push(msg.body % params)
      end

      def finish
        pc.save! if pc.changed?
      end

      def select_decision(collection)
        max = collection.sum(&:probability)
        collection.sort! {|a,b| b.probability <=> a.probability }

        collection.each do |item|
          if rand(max) <= item.probability
            return item
          end
          max -= item.probability
        end
        raise 'decision error'
      end

    end
  end
end
