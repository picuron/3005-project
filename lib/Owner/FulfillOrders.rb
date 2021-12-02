require_relative '../HelperLib/Helper.rb'

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
      ['1','2','3','4','5','6','7','8','9','10','11']
    end

    def fulfill_order
      puts "In fulfill order"
    end

    def print_orders_menu
      puts "\nWhat would you like to do?\n"\
      "[1] - Fulfill an order\n"\
      "[2] - See next 5 orders\n"\
      "[3] - See last 5 orders\n"\
      "[4] - Exit to Owner Menu\n"\
    end

    def print_orders_with_pagination(orders, index)
      Helper.clear
      if index < 0
        puts "You cannot go back further."
        index += 5
      elsif index > orders.length
        puts "You have already viewed all orders."
        index -= 5
      else
        5.times do |i|
          puts orders[i + index]
          break if i + index> orders.length
        end
        
      end

      while true
        print_orders_menu
        input = gets.chomp
        
        case input
        when '1'
          fulfill_order
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
  