module Mementus
  class Processor
    def initialize(graph, start_pipe)
      @graph = graph
      @pipeline = [start_pipe]
    end

    def append_next(pipe)
      @pipeline << pipe
    end

    def process
      output = nil
      @pipeline.each do |pipe|
        output = pipe.process(@graph, output)
      end
      output
    end

    def id
      process.id
    end

    def one
      output = process

      if output.respond_to?(:each)
        output.first
      else
        output
      end
    end

    def all
      process.to_a
    end

    def out
      append_next(Pipes::Outgoing.new)
      self
    end

    def out_e
      append_next(Pipes::OutgoingEdges.new)
      self
    end

    def in
      append_next(Pipes::Incoming.new)
      self
    end

    def in_e
      append_next(Pipes::IncomingEdges.new)
      self
    end
  end
end
