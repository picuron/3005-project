require 'pg'
require 'io/console'
require_relative '../GenStatements.rb'

module Client
  class BrowseBooksQueries
    def initialize(con)
      @con = con
    end

    def books_by_key_value(key, value)
      statement = "SELECT isbn, title FROM book WHERE $1=$2"
      @con.exec_params(statement, [key, value])
    end

    def add_to_cart(isbn, cart)
      if cart != nil
        @con.exec_params(GenStatements.gen_cart_books_statement, [cart, isbn])
        return cart
      else
        new_cart_id = instantiate_new_cart
        @con.exec_params(GenStatements.gen_cart_books_statement, [new_cart_id, isbn]) 
        return new_cart_id   
      end 
   end

   def instantiate_new_cart
    @con.exec("INSERT INTO cart VALUES(default)")
    (@con.exec("SELECT cart_id FROM cart ORDER BY cart_id DESC LIMIT 1")).values[0][0]
   end

    def book_by_isbn(isbn)
      statement = "SELECT "\
      "title, "\
      "isbn, "\
      "genre, "\
      "num_pages, "\
      "price, "\
      "num_in_stock, "\
      "num_sold, "\
      "name "\
      "FROM book "\
      "NATURAL JOIN publisher "\
      "NATURAL JOIN publisher_email "\
      "WHERE isbn =$1"
      @con.exec_params(statement, [isbn])
    end

    def authors_of_book(isbn)
      statement = "SELECT first_name, last_name "\
      "FROM author_books "\
      "NATURAL JOIN author "\
      "NATURAL JOIN author_email "\
      "WHERE isbn=$1"
      @con.exec_params(statement, [isbn])
    end
  end
end