module Eretheal
  module Manager
    class Base

      attr_reader :pc, :messages

      def initialize(character)
        @pc = character
        @pc.set_current!
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

      def combat
        @combat ||= Manager::Combat.new self
      end

      def position
        @position = Manager::Position.new self
      end

    end
  end
end
