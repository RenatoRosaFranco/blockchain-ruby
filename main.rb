# frozen_string_literal: true

require 'super_awesome_print'

require_relative 'lib/block'
require_relative 'lib/blockchain'
require_relative 'lib/book'

require_relative 'controllers/books_controller'

# BooksController instance
controller = BooksController.new

# Creates 2 books
controller.create_book("The Catcher in the Rye", "J.D. Salinger", "1951-07-16")
controller.create_book("To Kill a Mockingbird", "Harper Lee", "1960-07-11")

# Read the book
book = controller.read_book(1)
puts "Reading book ID: 1 #{book.title}, #{book.author}, #{book.published_date}"

# Update the Book
controller.update_book(1, "The Catcher in the Rye", "J.D. Salinger", "1951-07-16 (Updated)")

# Delete the book
controller.delete_book(2)

# List all books
puts 'All books:'
controller.all_books.each do |book|
  puts book.details
end

# Verify the blockchain nodes
puts 'Blockchain:'
controller.blockchain.chain.each do |block|
  ap block.details
end

# Graphviz
controller.blockchain.generate_graph
