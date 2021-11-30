require_relative '../HelperLib/Helper.rb'

module Owner
  class GenerateReports
    def initialize(session_object_in)
      @session_object_in = session_object_in
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In Generate Reports"
    end

    #Main Method
    def execute
      puts "In GenereateReports Execute"
      Helper.wait
    end 
  end
end
  