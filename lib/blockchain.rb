# frozen_string_literal: true

require 'digest'
require 'graphviz'

require_relative '../services/blockchain_graph_service.rb'

class Blockchain
  attr_reader :chain

  def initialize
    @chain = []
    @chain << Block.create_genesis_block
  end

  def add_block(operation, book)
    previous_block = chain.last

    block = Block.new(
      chain.size,
      Time.now,
      { operation:, book: },
      proof_of_work(previous_block.proof),
      previous_block.hash
    )

    chain << block
  end

  def proof_of_work(last_proof)
    proof = 0
    proof += 1 until valid_proof?(last_proof, proof)
    proof
  end

  def valid_proof?(last_proof, proof)
    guess = "#{last_proof}#{proof}"
    guess_hash = Digest::SHA256.hexdigest(guess)
    guess_hash.start_with?('0000')
  end

  def generate_graph(output_path = 'blockchain.png')
    graph_service = BlockchainGraphService.new(@chain)
    graph_service.generate_graph(output_path)
  end
end
