require_relative '../../HelperLib/Helper.rb'
require_relative './Checkout.rb'
require_relative './RemoveBooks.rb'
require_relative '../../Database/ClientQueries/CartQueries.rb'

module Client
  class Cart 
    def fetch_cart(cart_id)
      con = @session.db_connection_open
      cart = CartQueries.new(con).my_cart(cart_id)
      @session.db_connection_close(con)
      return cart
    end

    def print_cart(cart_records)
      cart_items = []
      cart_records.each do |book|
        cart_items << book
      end
      puts cart_items
    end
  end


  class CartController < Cart
    def initialize(session_object_in, cart_id)
      @session = session_object_in
      @cart = cart_id
      Helper.clear
      execute
    end

    # def fetch_cart(cart_id)
    #   con = @session.db_connection_open
    #   cart = CartQueries.new(con).my_cart(cart_id)
    #   @session.db_connection_close(con)
    #   return cart
    # end

    # def print_cart(cart_records)
    #   cart_items = []
    #   cart_records.each do |book|
    #     cart_items << book
    #   end
    #   puts cart_items
    # end

    private
    # Helper Functions
    def cart_menu_display
      Helper.clear
      puts "\nHere is everything in your Cart\n\n"

      print_cart(fetch_cart(@cart))

      puts "\nWhat would you like to do?\n"\
      "[1] - Proceed to Checkout\n"\
      "[2] - Remove Books From Cart\n"\
      "[3] - Return To Main Menu \n"
    end

    def cart_controller
      while true
        cart_menu_display
        input = gets.chomp
        case input
        when '1'
          Checkout.new(@session)
        when '2' 
          RemoveBooks.new(@session, @cart)
        when '3'
          break
        else
          Helper.invalid_entry_display
        end
      end
    end

    #Main Method
    def execute
      cart_controller
      Helper.wait
    end 
  end
end