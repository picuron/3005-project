require_relative '../HelperLib/Helper.rb'

module Owner
  class AddBook
    def initialize(session_object_in)
      @session_object_in = session_object_in
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In AddBook"
    end

    #Main Method
    def execute
      puts "In AddBook Execute"
      Helper.wait
    end 
  end
end
  