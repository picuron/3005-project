require_relative '../HelperLib/Helper.rb'
require_relative '../Database/OwnerQueries/FulfillOrdersQueries.rb'

module Owner
  class FulfillOrders
      
    def initialize(session_object_in, login_session)
      @session_object_in = session_object_in
      @login_session = login_session
      Helper.clear
      execute
    end

    private

    # Will Eager load - load every single unfulfilled item
    def get_unfulfilled_orders
      puts "One moment, fetching orders."
      con = @session_object_in.db_connection_open
      orders = FulfillOrdersQueries.new(con).get_orders
      @session_object_in.db_connection_close(con)

      order_array = []

      orders.each do |order|
        order_array << order["order_number"]
      end
      order_array
    end

    def invalid_order_number_menu
      puts "Invalid order number. What would you like to do?\n"\
          "[1] - See orders\n"\
          "[2] - Try Again\n"\
    end

    def post_fulfillment_menu
      puts "\nWhat would you like to do?\n"\
      "[1] - View/Fulfill another order\n"\
      "[2] - Exit to owner menu\n"\
    end

    def fulfill_order(orders)
      input = ""
      while true
        puts "\nEnter order number: "
        input = gets.chomp

        break if(orders.include?(input))

        while true
          invalid_order_number_menu
          option = gets.chomp

          case option
          when '1'
            print_orders_with_pagination(orders, 0)
          when '2'
            break
          else
            Helper.invalid_entry_display
          end
        end
      end

      con = @session_object_in.db_connection_open
      
      get_owner_statement = "SELECT o_id FROM owner WHERE username=$1 AND password=$2"
      response = con.exec_params(get_owner_statement, [@login_session[:username], @login_session[:password]])
      owner_id = response.values[0][0]
      
      FulfillOrdersQueries.new(con).fulfill_order(input, owner_id)
      
      @session_object_in.db_connection_close(con)

      Helper.clear
      puts "Order has successfully been fulfilled!"
      while true
        post_fulfillment_menu
        option = gets.chomp

        case option
        when '1'
          print_orders_with_pagination(get_unfulfilled_orders, 0)
        when '2'
          OwnerController.new(@session_object_in, @login_session)
        else
          Helper.invalid_entry_display
        end
      end
    end

    def print_orders_menu
      puts "\nWhat would you like to do?\n"\
      "[1] - Fulfill an order\n"\
      "[2] - See next 5 orders\n"\
      "[3] - See last 5 orders\n"\
      "[4] - Exit to Owner Menu\n"\
    end

    def print_orders_with_pagination(orders, index)
      puts orders
      Helper.clear
      if index < 0
        puts "You cannot go back further."
        # index += 5
      elsif index >= orders.length
        puts "You have already viewed all orders."
        # index -= 5
      else
        5.times do |i|
          puts "Order " + orders[i + index] if orders[i + index]
          break if i + index -1> orders.length
        end
        
      end

      while true
        print_orders_menu
        input = gets.chomp
        
        case input
        when '1'
          fulfill_order(orders)
        when '2'
          print_orders_with_pagination(orders, index + 5)
        when '3'
          print_orders_with_pagination(orders, index - 5)
        when '4'
          OwnerController.new(@session_object_in, @login_session)
        else
          Helper.invalid_entry_display
        end
      end
    end

    def fulfill_items_menu
      Helper.clear
      puts "\nHere are your options: \n"\
      "[1] - Exit Program\n"\
      "[2] - Exit To Owner Menu\n"\
      "[3] - View first 5 unfulfilled orders\n"\
    end
    
    #Main Method
    def execute
      Helper.clear
      unfulfilled_orders = get_unfulfilled_orders
      while true
        fulfill_items_menu
        input = gets.chomp
        case input
        when '1'
          Helper.exit_program
        when '2'
          OwnerController.new(@session_object_in, @login_session)
        when '3'
          print_orders_with_pagination(unfulfilled_orders, 0)
        else
          Helper.invalid_entry_display
        end
      end
    end 
  end
end
  