# frozen_string_literal: true

require 'digest'

class Block
  attr_reader :index, :timestamp, :data, :proof, :previous_hash, :hash

  def initialize(index, timestamp, data, proof, previous_hash)
    @index = index
    @timestamp = timestamp
    @data = data
    @proof = proof
    @previous_hash = previous_hash
    @hash = self.class.calculate_hash(self)
  end

  def details
    {
      index:,
      timestamp:,
      data:,
      proof:,
      previous_hash:,
      hash:
    }
  end

  class << self
    def create_genesis_block
      Block.new(0, Time.now, { operation: 'genesis', book: nil }, 100, '1')
    end

    def calculate_hash(block)
      block_string = "#{block.index}#{block.timestamp}#{block.data}#{block.proof}#{block.previous_hash}"
      Digest::SHA256.hexdigest(block_string)
    end
  end
end
