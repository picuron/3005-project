require './Database/InitDB'
require './Client/ClientController'
require './Owner/OwnerController'

# After the program is launched, the user instantly gets pointed here
class BookStoreController

    def initalize
        puts "\e[2J\e[f" #This is an ANSI escape which essentially clears the terminal (without actually clearing it)
        dbSessionObject = fetch_sesssion_object()
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

    def user_input()
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

    def fetch_sesssion_object()
        return Database::InitDB.new.connect
    end
    
    #def should_init_db?
    #  puts "Would you like to initalize the database? (Y/N)"
    #  while user_input = gets.chomp # loop while getting user input
    #    case user_input
    #    when "Y"
    #      return true
    #      break 
    #    when "N"
    #      return false
    #      break 
    #    else
    #      puts "Invalid Input. Enter Y or N."
    #    end
    #  end
    #end

end

