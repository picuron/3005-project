require_relative '../HelperLib/Helper.rb'

module Owner
  class AddBook
    def initialize(session_object_in, login_session)
      @session_object_in = session_object_in
      @login_session = login_session
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In AddBook"
    end

    def get_publishers
      ["Publisher 1", "Publisher 2"]
    end

    def print_publishers(publishers)
      publishers.each {|publisher|
        puts publisher
      }
    end

    def was_publisher_present?
      puts "Was your publisher listed? (Y/N)"
      while user_input = gets.chomp 
        case user_input
        when "Y"
          return true
          break 
        when "N"
          return false
          break 
        else
          puts "Invalid Input. Enter Y or N."
        end
      end
    end

    def create_publisher
      puts "Create publisher"
    end

    #Main Method
    def execute
      Helper.clear
      publishers = get_publishers
      print_publishers(publishers)
      
      publisher_present = was_publisher_present?

      create_publisher unless publisher_present
    end 
  end
end
  