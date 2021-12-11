require_relative '../HelperLib/Helper.rb'
require_relative '../Database/ClientQueries/OrdersQueries.rb'
require 'pry'

module Client
  class Orders
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

    private
    def fetch_user_orders
      con = @session.db_connection_open
      orders = OrdersQueries.new(con).fetch_user_orders(@user)
      @session.db_connection_close(con)
      return orders
    end

    def fetch_books_in_order(order_number)
      con = @session.db_connection_open
      books = OrdersQueries.new(con).fetch_books_in_order(order_number)
      @session.db_connection_close(con)
      return books
    end

    def display_all_info_about_order(order, books)
      total_price = 0
      puts "\n\-------------- Order #{order["day"]}/#{order["month"]}/#{order["year"]} -----------------\n"
      books.values.each do |book|
        puts "   Title: #{book[0]}".ljust(30) + " Price: $#{book[1]}"
        total_price += book[1].to_f
      end
      puts "\n Total Price: #{total_price.round(2)}"
      puts "\n Status: #{order["status"]}"
      puts "\n Current Location: #{order["cl_city"]}, #{order["cl_country"]}"
    end

    #Main Method
    def execute
      orders = fetch_user_orders
      if orders.values.length == 0
        puts "You have No Orders Yet, Go Add A Book To Your Cart."
        Helper.wait
      else
        puts "Here all all of your orders on record: "
        orders.each do |order|
          books = fetch_books_in_order(order["order_number"])
          display_all_info_about_order(order, books)
          #puts order
        end
        Helper.wait
      end
      #updates the state as we exit file
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
    end
  end
end