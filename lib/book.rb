# frozen_string_literal: true

class Book
  attr_accessor :id, :title, :author, :published_date

  def initialize(id, title, author, published_date)
    @id = id
    @title = title
    @author = author
    @published_date = published_date
  end

  def details
    "#{id} - #{title} - #{author} - #{published_date}"
  end
end
