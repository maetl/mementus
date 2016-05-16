require 'thread'

module Mementus
  class IntegerId
    def self.start_from(start_value)
      @generator ||= self.new(start_value)
    end

    def self.next_id
      @generator ||= self.new
      @generator.next_id
    end

    def initialize(start_value=1)
      @current_value = start_value
      @mutex = Mutex.new
    end

    def next_id
      @mutex.lock
      allocated = @current_value
      @current_value += 1
      @mutex.unlock
      allocated
    end
  end
end
