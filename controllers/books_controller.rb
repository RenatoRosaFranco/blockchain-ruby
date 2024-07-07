# frozen_string_literal: true

class BooksController
  def initialize
    @books = []
    @blockchain = Blockchain.new
  end

  def create_book(title, author, published_date)
    id = @books.size + 1
    book = Book.new(id, title, author, published_date)
    @books << book
    @blockchain.add_new_block('create', book)
    book
  end

  def read_book(id)
    @books.find { |book| book.id == id }
  end

  def update_book(id, title, author, published_date)
    book = read_book(id)
    return unless book

    book.title = title
    book.author = author
    book.published_date = published_date
    @blockchain.add_new_block('update', book)
    book
  end

  def delete_book(id)
    book = read_book(id)
    @books.delete(book) if book
    @blockchain.add_block('delete', book) if book
    book
  end

  def all_books
    @books
  end
end
