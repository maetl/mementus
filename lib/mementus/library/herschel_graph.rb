module Mementus
  module Library
    # The Herschel graph is a bipartite undirected graph with 11 vertices and
    # 18 edges, the smallest non-Hamiltonian polyhedral graph.
    #
    #         __________(blue-1)__________
    #        /          /      \          \
    #       /          /        \          \
    #      /       (red-1)    (red-2)       \
    #     /         /  \        /  \         \
    #    /         /    \      /    \         \
    # (red-3)--(blue-2) (blue-3) (blue-4)---(red-4)
    #    \         \    /      \    /         /
    #     \         \  /        \  /         /
    #      \       (red-5)    (red-6)       /
    #       \          \        /          /
    #        \          \      /          /
    #         \_________(blue-5)_________/
    #
    class HerschelGraph < Graph
      def self.instance
        self.new do
          create_edge do |edge|
            edge.from = "red-1"
            edge.to = "blue-1"
          end

          create_edge do |edge|
            edge.from = "red-1"
            edge.to = "blue-2"
          end

          create_edge do |edge|
            edge.from = "red-1"
            edge.to = "blue-3"
          end

          create_edge do |edge|
            edge.from = "red-2"
            edge.to = "blue-1"
          end

          create_edge do |edge|
            edge.from = "red-2"
            edge.to = "blue-3"
          end

          create_edge do |edge|
            edge.from = "red-2"
            edge.to = "blue-4"
          end

          create_edge do |edge|
            edge.from = "red-3"
            edge.to = "blue-1"
          end

          create_edge do |edge|
            edge.from = "red-3"
            edge.to = "blue-2"
          end

          create_edge do |edge|
            edge.from = "red-3"
            edge.to = "blue-5"
          end

          create_edge do |edge|
            edge.from = "red-4"
            edge.to = "blue-1"
          end

          create_edge do |edge|
            edge.from = "red-4"
            edge.to = "blue-4"
          end

          create_edge do |edge|
            edge.from = "red-4"
            edge.to = "blue-5"
          end

          create_edge do |edge|
            edge.from = "red-5"
            edge.to = "blue-2"
          end

          create_edge do |edge|
            edge.from = "red-5"
            edge.to = "blue-3"
          end

          create_edge do |edge|
            edge.from = "red-5"
            edge.to = "blue-5"
          end

          create_edge do |edge|
            edge.from = "red-6"
            edge.to = "blue-3"
          end

          create_edge do |edge|
            edge.from = "red-6"
            edge.to = "blue-4"
          end

          create_edge do |edge|
            edge.from = "red-6"
            edge.to = "blue-5"
          end
        end
      end
    end
  end
end
