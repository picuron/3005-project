require 'pg'
require 'io/console'
require_relative '../GenStatements.rb'

module Client
  class RemoveBooksQueries
    def initialize(con, cart)
      @con = con
      @cart = cart
    end

    def remove_book_from_cart_by_isbn(isbn)
      statement = "DELETE FROM cart_books WHERE isbn =$1 AND cart_id=$2"
      @con.exec_params(statement, [isbn, @cart])
    end

  end
end