require 'pg'
require 'io/console'
require_relative '../GenStatements.rb'

module Client
  class CartQueries
    def initialize(con)
      @con = con
    end

    def my_cart(cart_id)
        statement = "SELECT isbn, title, price "\
        "FROM cart_books "\
        "NATURAL JOIN book "\
        "WHERE cart_id =$1"
        @con.exec_params(statement, [cart_id])
    end
  end
end
