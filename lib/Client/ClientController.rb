require_relative '../HelperLib/Helper.rb'
require_relative './Orders.rb'
require_relative './SearchForBooks.rb'
require_relative './BrowseBooks.rb'
require_relative './Cart/CartController.rb'

module Client
  class ClientController
    def initialize(session_object_in)
      @db = session_object_in
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
      "[3] - get DB printout of all courses names\n"\
      "[4] - Browse Books\n"\
      "[5] - Search for Book\n"\
      "[6] - View Cart\n"\
      "[7] - View Orders\n"
    end

    #Helper Functions
    def main_menu_case_2
      Helper.clear
      # connection_object = @db.db_connection_open
      # puts connection_object.exec('SELECT title FROM course').values
      # @db.db_connection_close(connection_object)
      connection_object = @db.db_connection_open
      puts connection_object.exec('SELECT title FROM course').values
      @db.db_connection_close(connection_object)
      Helper.wait
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
          BookStoreController.new.initalize(@db)
        when '3'
          main_menu_case_2
        when '4'
          BrowseBooks.new(@db)
        when '5'
          SearchForBooks.new(@db)
        when '6'
          CartController.new(@db)
        when '7'
          Oders.new(@db)
        else
          Helper.invalid_entry_display
        end
      end 
    end
  end
end
