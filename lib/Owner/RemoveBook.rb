require_relative '../HelperLib/Helper.rb'

module Owner
  class RemoveBook
    def initialize(session_object_in)
      @session_object_in = session_object_in
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In RemoveBook"
    end

    #Main Method
    def execute
      puts "What is the ISBN of the book you wish to remove?"
      removal_ISBN = gets.chomp

      #Call removal SQL

      puts "That ISBN has been removed!"
      Helper.wait
    end 
  end
end
  