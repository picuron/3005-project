require_relative '../HelperLib/Helper.rb'
require_relative './FulfillOrders.rb'
require_relative './AddBook.rb'
require_relative './RemoveBook.rb'
require_relative './GenerateReports.rb'

module Owner
  class OwnerController
      
    def initialize(session_object_in, login_session = nil)
      @session_object_in = session_object_in
      @login_session = login_session
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In Owner Controller"
    end

    def owner_log_in
      puts @login_session
      if @login_session == nil
        Helper.clear
        puts "Hello! To proceed to the owner page, you must log in as the owner."
        puts "--The default owner login is:--"
        puts "--Username: ElRoby--"
        puts "--Password: COMP3005--"
        puts "\n"

        puts "Please enter your username:"
        username = gets.chomp
        puts "Please enter your password:"
        password = gets.chomp
      else
        username = @login_session[:username]
        password = @login_session[:password]
      end

      #Hardcoding this now until we get DB set up
      return true if login_successfully_validated(username, password)
      invalid_password_menu
    end

    def login_successfully_validated(username, password)
      con = @session_object_in.db_connection_open

      login_statement = "SELECT COUNT(*) FROM owner WHERE username=$1 AND password=$2"
      query_result = con.exec_params(login_statement, [username, password])

      @session_object_in.db_connection_close(con)
      
      if(query_result.values[0][0].to_i > 0)
        @login_session = Helper::LoginSession.new.initalize(username, password)
        return true
      end
      false
    end

    def invalid_password_menu_list
      Helper.clear
      puts "\nYour login is invalid. You will have to attempt to login as owner again, or log in as a customer. What would you like to do?"
      puts "[1] - Attempt to log in again.\n"\
      "[2] - Return to user selection\n"\
    end

    def invalid_password_menu
      while true
        invalid_password_menu_list
        input = gets.chomp
        case input
        when '1'
          execute
        when '2'
          BookStoreController.new.initalize(@session_object_in)
        else
          Helper.invalid_entry_display
        end
      end
    end

    def owner_menu_case_1
      Helper.exit_program
    end

    def owner_menu_case_2
      FulfillOrders.new(@session_object_in, @login_session)
    end

    def owner_menu_case_3
      AddBook.new(@session_object_in, @login_session)
    end

    def owner_menu_case_4
      RemoveBook.new(@session_object_in)
    end

    def owner_menu_case_5
      GenerateReports.new(@session_object_in, @login_session)
    end

    def owner_menu_options 
      Helper.clear
      puts "\nWelcome back Owner! What would you like to Do? \n"\
      "[1] - Exit\n"\
      "[2] - Exit To Owner/Client Menu\n"\
      "[3] - Fulfill Orders\n"\
      "[4] - Add Book\n"\
      "[5] - Remove Book\n"\
      "[6] - Generate Reports\n"\
    end

    #Main Method
    def execute
      return if !owner_log_in
      while true
        owner_menu_options
        input = gets.chomp
        case input
        when '1'
          owner_menu_case_1
        when '2'
          BookStoreController.new.initalize(@session_object_in)
        when '3'
          owner_menu_case_2
        when '4'
          owner_menu_case_3
        when '5'
          owner_menu_case_4
        when '6'
          owner_menu_case_5
        else
          Helper.invalid_entry_display
        end
      end
    end 
  end
end
  