require_relative '../HelperLib/Helper.rb'

module Owner
  class FulfillOrders
      
    def initialize(session_object_in)
      @session_object_in = session_object_in
      Helper.clear
      message
      execute
    end

    private
    # Helper Functions
    def message
      puts "In FulfillOrders"
    end

    #Main Method
    def execute
      puts "In FulfillOrdersExecute"
      Helper.wait
    end 
  end
end
  