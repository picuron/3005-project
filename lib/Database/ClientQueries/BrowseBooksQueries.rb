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
        begin
          @con.exec_params(GenStatements.gen_cart_books_statement, [cart, isbn])
        rescue PG::UniqueViolation
          puts "So this is another design flaw. We modelled isbn as the PK, meaning the "\
          "join table between books and cart required the PK from books and the PK from cart "\
          ". Therefore, adding in the same book twice causes a violation. If we had more time to "\
          " perfect this, each instance of a book to should a unique id, and the isbn should not be used as PK. "\
          "That, or something like we increment a x2 x3 type thing, but again, we do not have time to implement this."
          Helper.wait
        end
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