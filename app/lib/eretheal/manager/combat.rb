module Eretheal
  module Manager
    class Combat
      attr_accessor :actors
      attr_reader :base
      delegate :pc, :add_message, to: :base

      def initialize(base)
        @base = base
        @actors = []
      end

      def initialize_actors
        @actors.each do |actor|
          actor.set_action!(@actors) if actor.action.nil?
        end
      end

      def run
        raise 'combat actors is empty.' if @actors.empty?
        loop { break if count }
        @actors.sort! { |a,b| b.charge_time <=> a.charge_time }
        execute_actions
      end

      def count
        action = false
        @actors.each do |actor|
          actor.charge_time += actor.action_speed
          action = true if actor.charge_time >= 100
        end
        action
      end

      def execute_actions
        @actors.each do |actor|
          actor.action! if actor.charge_time >= 100
        end
      end

    end
  end
end
