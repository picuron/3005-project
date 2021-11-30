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
      puts "In RemoveBook Execute"
      Helper.wait
    end 
  end
end
  