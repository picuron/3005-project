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

    def get_phone_numbers_menu
      puts "\nHere are your options: \n"\
      "\n[1] - Done Entering Phone Numbers\n"\
      "[2] - Add another phone number\n"\
    end

    def get_phone_numbers
      puts "Please enter a phone number: "
      phone_number_1 = gets.chomp

      phone_numbers = [phone_number_1]      

      while true
        get_phone_numbers_menu
        input = gets.chomp
        
        case input
        when '1'
          return phone_numbers
        when '2'
          puts "Enter another phone number:"
          phone_number_input = gets.chomp
          phone_numbers.push(phone_number_input)
        else
          Helper.invalid_entry_display
        end
      end
    end

    def create_publisher
      puts "Enter the publisher name:"
      name = gets.chomp
      puts "Enter the publishers email:"
      email = gets.chomp
      phone_numbers = get_phone_numbers
      puts "Enter the publishers street number:"
      street_number = gets.chomp
      puts "Enter the publishers street name:"
      street_name = gets.chomp
      puts "Enter the publishers city:"
      city = gets.chomp
      puts "Enter the publishers country:"
      country = gets.chomp
      puts "Enter the publishers postal code:"
      postal_code = gets.chomp
      puts "Enter the publishers bank account number:"
      bank_account_number = gets.chomp
      account_value = 0

      # Call create publisher query here, return back the ID of it
      publisher_id = 101
      return publisher_id
    end

    #Main Method
    def execute
      Helper.clear
      publishers = get_publishers
      print_publishers(publishers)
      
      publisher_present = was_publisher_present?

      if publisher_present
        puts "What was the publisher's ID?"
        publisher_id = gets.chomp
      else
        publisher_id = create_publisher  
      end

      puts "What is the books ISBN"
      #It might be a good idea to do some validation and make sure the ISBN is unique here
      isbn = gets.chomp
      puts "What is the books title"
      title = gets.chomp
      puts "What is the books genre?"
      genre = gets.chomp
      puts "What is the books royalty. Write a percent as a decimal. IE. 5% = 0.05"
      royalty = gets.chomp
      puts "What is the books price?"
      price = gets.chomp
      puts "What is the books cost?"
      cost = gets.chomp
      puts "Enter current stock of the book"
      stock = gets.chomp
      threshold_num = 0
      num_sold = 0
      
      puts "\n Thank you! #{title} is being added."
      Helper.wait
      #Create book in DB given this info
    end 
  end
end
  