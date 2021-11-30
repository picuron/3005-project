require './Database/InitDB'
require './Client/ClientController'
require './Owner/OwnerController'
require './HelperLib/Helper'

# After the program is launched, the user instantly gets pointed here
class BookStoreController

    def initalize(db_session_object = nil)
      Helper.clear 
      if(db_session_object)
        session_object = db_session_object
      else
        db_session_object = fetch_sesssion_object
        session_object = Helper::HelperConnection.new(db_session_object)
      end
      puts session_object
      prompt_for_owner_or_client(session_object)
    end

    private

    def prompt_for_owner_or_client(session)
      if user_input == 'C'
        Client::ClientController.new(session)
      else
        Owner::OwnerController.new(session)
      end
    end

    def user_input
      Helper.clear
      puts "\nWould you like to proceed as a Client or a Owner? (C/O)"
      while user_input = gets.chomp # loop while getting user input
        case user_input
        when 'C'
          return user_input
          break 
        when 'O'
          return user_input
          break 
        else
          puts "Invalid Input. Enter C or O."
        end
      end
    end

    def fetch_sesssion_object
      Database::InitDB.new.connect
    end
end

