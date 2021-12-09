require 'pg'
require 'io/console'
require_relative '../GenStatements.rb'

module Client
  class CheckoutQueries
    def initialize(con, cart)
      @con = con
      @cart = cart
    end
  end
end
