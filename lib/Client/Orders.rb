require_relative '../HelperLib/Helper.rb'

module Client
  class Orders
    def initialize(session_object_in)
      @db = session_object_in
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In Orders"
    end

    #Main Method
    def execute
      puts "In Orders Execute"
      Helper.wait
    end 
  end
end