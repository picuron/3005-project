require_relative '../HelperLib/Helper.rb'

module Owner
  class OwnerController
      
    def initalize(session_object_in)
      @session_object_in = session_object_in
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In Owner Controller"
    end

    #Main Method
    def execute
      puts "hellloo\n"
      Helper.wait
      Helper.clear
      Helper.wait
    end 
  end
end
  