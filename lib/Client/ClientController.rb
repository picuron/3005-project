require_relative '../HelperLib/Helper.rb'
require_relative './Orders.rb'
require_relative './BrowseBooks.rb'
require_relative './Cart/CartController.rb'

module Client
  class ClientController
    def initialize(session_object_in)
      @session = session_object_in
      @cart = nil
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
      connection_object = @session.db_connection_open
      rs = connection_object.exec('SELECT * FROM region NATURAL JOIN address')
      rs.each do |row|
        puts "%s | %s | %s | %s | %s | %s" % [ row['address_id'], row['street_number'], row['street_name'], row['postal_code'], row['city'], row['country'] ]
      end
      
      @session.db_connection_close(connection_object)
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
          BookStoreController.new(@session)
        when '3'
          main_menu_case_2
        when '4'
          # i dont like this patter, but im not sure how to maintain cart state
          @cart = BrowseBooks.new(@session, @cart).cart
        when '5'
          SearchForBooks.new(@session)
        when '6'
          CartController.new(@session, @cart)
        when '7'
          Oders.new(@session)
        else
          Helper.invalid_entry_display
        end
      end 
    end
  end
end
