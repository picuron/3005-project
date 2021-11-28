require './Database/InitDB'
require './Client/ClientController'
require './Owner/OwnerController'
require './HelperLib/Helper'

# After the program is launched, the user instantly gets pointed here
class BookStoreController

    def initalize
      Helper.clear 
      dbSessionObject = fetch_sesssion_object
      prompt_for_owner_or_controller(dbSessionObject)
    end

    private

    def prompt_for_owner_or_controller(sessionObjctIn)
      if user_input == 'C'
        Client::ClientController.new.initalize(sessionObjctIn)
      else
        Owner::OwnerController.new.initalize(sessionObjctIn)
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

