module Eretheal
  class Response
    attr_reader :character, :messages
    def initialize(character=nil)
      @character = character
    end
  end
end
