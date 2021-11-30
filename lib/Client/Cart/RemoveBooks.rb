require_relative '../../HelperLib/Helper.rb'

module Client
  class RemoveBooks
    def initialize(session_object_in)
      @db = session_object_in
      Helper.clear
      execute
    end

    private
    # Helper Functions
    def books_remove
      array_of_ISBNs_to_remove = Array.new
      Helper.clear
      puts "Please Enter the ISBN for the book to want to remove, followed by enter.\n"\
      "Do not include spaces or commas\n"\
      "When Done, Press Enter Again to Submit\n"
      while true
        input = gets.chomp
        case input
        when ''
          break
        else 
          array_of_ISBNs_to_remove.push(input)
        end
      end

      Helper.clear
      puts "\nThe following books have been remved from your cart\n"
      puts array_of_ISBNs_to_remove
      Helper.wait
    end


    #Main Method
    def execute
      puts "In Orders Execute"
      books_remove
      Helper.wait
    end 
  end
end