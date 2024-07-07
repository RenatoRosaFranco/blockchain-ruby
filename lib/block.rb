# frozen_string_literal: true

class Block
  attr_reader :index, :timestamp, :data, :proof, :previous_hash

  def initialize(index, timestamp, data, proof, previous_hash)
    @index = index
    @timestamp = timestamp
    @data = data
    @proof = proof
    @previous_hash = previous_hash
  end

  class << self
    def create_genesis_block
      Block.new(0, Time.now, { operation: 'genesis', book: nil }, 100, '1')
    end

    def hash(block)
      block_string = "#{block.index}#{block.timestamp}#{block.data}#{block.proof}#{block.previous_hash}"
      Digest::SHA256.hexadigest(block_string)
    end
  end
end
