# frozen_string_literal: true

require 'digest'

class Blockchain
  attr_reader :chain

  def initialize
    @chain = []
    @chain << Block.create_genesis_block
  end

  def add_block(operation, book)
    block = Block.new(
      @chain.size,
      Time.now,
      { operation:, book: },
      proof_of_work,
      Block.hash(@chain.last)
    )
    @chain << block
  end

  def proof_of_work
    proof = 0
    proof += 1 until valid_proof?(proof)
    proof
  end

  def valid_proof?(proof)
    guess = "#{@chain.last.proof}#{proof}"
    guess_hash = Digest::SHA256.hexdigest(guess)
    guess_hash.start_with?('0000')
  end
end
