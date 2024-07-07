# frozen_string_literal: true

require 'graphviz'

class BlockchainGraphService
  def initialize(chain)
    @chain = chain
  end

  def generate_graph(output_path = 'blockchain.png')
    g = GraphViz.new(:G, type: :digraph)

    @chain.each do |block|
      label = "Block #{block.index}\nHash: #{block.hash[0..7]}\nPrev Hash: #{block.previous_hash[0..7]}\nTimestamp: #{block.timestamp}\nOperation: #{block.data[:operation]}"
      g.add_nodes(block.index.to_s, label: label, shape: 'box')
    end

    @chain.each_with_index do |block, index|
      next if index.zero?

      g.add_edges(@chain[index - 1].index.to_s, block.index.to_s)
    end

    g.output(png: output_path)
  end
end
