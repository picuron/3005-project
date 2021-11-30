require_relative '../../HelperLib/Helper.rb'
require_relative './Checkout.rb'
require_relative './RemoveBooks.rb'

module Client
  class CartController
    def initialize(session_object_in)
      @db = session_object_in
      Helper.clear
      execute
    end

    private
    # Helper Functions
    def cart_menu_display
      Helper.clear
      puts "\nHere is everything in your Cart\n"\
      "...contents of cart...\n"\
      "What would you like to do?\n"\
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
          Checkout.new(@db)
        when '2' 
          RemoveBooks.new(@db)
        when '3'
          break
        else
          Helper.invalid_entry_display
        end
      end
    end

    #Main Method
    def execute
      puts "In Cart Execute"
      Helper.wait
      cart_controller
      Helper.wait
    end 
  end
end