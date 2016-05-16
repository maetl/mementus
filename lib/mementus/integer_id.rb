require 'thread'

module Mementus
  class IntegerId
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
