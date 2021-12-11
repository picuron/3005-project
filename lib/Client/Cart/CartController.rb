require_relative '../../HelperLib/Helper.rb'
require_relative './Checkout.rb'
require_relative './RemoveBooks.rb'
require_relative '../../Database/ClientQueries/CartQueries.rb'

module Client
  class CartController
    attr_accessor :cart
    attr_accessor :session
    attr_accessor :user
    attr_accessor :state
    def initialize(session, cart, user)
      @session = session
      @cart = cart
      @user = user
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
      Helper.clear
      execute
    end

    def fetch_cart(cart_id)
      con = @session.db_connection_open
      cart_items = CartQueries.new(con).my_cart(cart_id)
      @session.db_connection_close(con)
      return cart_items
    end

    def print_cart(cart_records)
      total_price = 0
      cart_items = []
      cart_records.each do |book|
        cart_items << book
        total_price += book["price"].to_f
      end
      puts cart_items
      puts "\n Total Price: $#{total_price.round(2)}"
    end

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
        if (fetch_cart(@cart).values.length == 0)
          puts "Looks Like Your Cart is Empty, Go Add Something!"
          Helper.wait
          break
        else
          cart_menu_display
          input = gets.chomp
          case input
          when '1'
            state = Checkout.new(@session, @cart, @user).state
            @session = state["session"]
            @cart = state["cart"]
            @user = state["user"]
          when '2'
            state = RemoveBooks.new(@session, @cart, @user).state
            @session = state["session"]
            @cart = state["cart"]
            @user = state["user"]
          when '3'
            break
          else
            Helper.invalid_entry_display
          end
        end
      end
    end

    #Main Method
    def execute
      cart_controller
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
    end
  end
end