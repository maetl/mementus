module Mementus
  module Library
    # Demo of an interactive fiction story with passages represented as nodes
    # and choices represented as edges.
    class StoryGraph < Graph
      def self.instance
        self.new do
          create_node do |node|
            node.id = "start"
            node.label = :passage
            node.props[:text] = "The start of a story."
          end

          create_node do |node|
            node.id = "happy-ending"
            node.label = :passage
            node.props[:text] = "A happy ending."
          end

          create_node do |node|
            node.id = "tragic-ending"
            node.label = :passage
            node.props[:text] = "A tragic ending."
          end

          create_edge do |edge|
            edge.id = "happy-choice"
            edge.label = :choice
            edge.from = "start"
            edge.to = "happy-ending"
            edge.props[:text] = "Choose wisely."
          end

          create_edge do |edge|
            edge.id = "tragic-choice"
            edge.label = :choice
            edge.from = "start"
            edge.to = "tragic-ending"
            edge.props[:text] = "Choose poorly."
          end
        end
      end
    end
  end
end
