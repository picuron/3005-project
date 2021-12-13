require_relative '../HelperLib/Helper.rb'
require_relative './Orders.rb'
require_relative './BrowseBooks.rb'
require_relative './SearchForBooks.rb'
require_relative './Cart/CartController.rb'

module Client
  class ClientController
    attr_accessor :cart
    attr_accessor :session
    attr_accessor :user
    #state elements
    def initialize(session)
      @session = session
      @cart = nil
      @user = nil
      Helper.clear
      execute
    end

    private
    #menu options used in execute
    def main_menu_display
      Helper.clear
      puts "\nWelcome to the BookStore, What would you like to Do? \n"\
      "[1] - Exit Program\n"\
      "[2] - Exit to Client/Owner menu\n"\
      "[3] - Browse Books\n"\
      "[4] - Search for Book\n"\
      "[5] - View Cart\n"\
      "[6] - View Orders\n"
    end

    #Main Method
    def execute
      while true
        main_menu_display
        input = gets.chomp
        case input
        when '1'
          Helper.exit_program
        when '2'
          BookStoreController.new(@session)
        when '3'
          # Everytime we exit a deeper object, we fetch the state at that point, and update the state at this outer level
          # this way, next time we go an object deeper, we can pass it in the updated state.
          state = BrowseBooks.new(@session, @cart, @user).state
          @session = state["session"]
          @cart = state["cart"]
          @user = state["user"]
        when '4'
          state = SearchForBooks.new(@session, @cart, @user).state
          @session = state["session"]
          @cart = state["cart"]
          @user = state["user"]
        when '5'
          state = CartController.new(@session, @cart, @user).state
          @session = state["session"]
          @cart = state["cart"]
          @user = state["user"]
        when '6'
          state = Orders.new(@session, @cart, @user).state
          @session = state["session"]
          @cart = state["cart"]
          @user = state["user"]
        else
          Helper.invalid_entry_display
        end
      end
    end
  end
end
