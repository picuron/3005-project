require 'pg'
require 'io/console'
require_relative '../GenStatements.rb'

module Client
  class CheckoutQueries
    def initialize(con)
      @con = con
    end

    def generate_checkout_success?(user, cart, shipping_hash, billing_hash)
      statement = "SELECT isbn, title, price "\
      "FROM cart_books "\
      "NATURAL JOIN book "\
      "WHERE cart_id =$1"
      @con.exec_params(statement, [cart_id])

      # if success, return true
      return true
    end
  end
end
