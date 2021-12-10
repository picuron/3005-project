require_relative '../HelperLib/Helper.rb'
require_relative '../Database/ClientQueries/OrdersQueries.rb'

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
      orders = OrdersQueries.new(con).fetch_user_orders(user)
      @session.db_connection_close(con)
      return orders
    end

    #Main Method
    def execute
      orders = fetch_user_orders
      if orders.values.length == 0
        puts "You have No Orders Yet, Go Add A Book To Your Cart."
        Helper.wait
      else
        orders_array = []
        orders.each do |order|
          orders_array << order
        end
        puts orders_array
        Helper.wait
      end
      #updates the state as we exit file
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
    end
  end
end