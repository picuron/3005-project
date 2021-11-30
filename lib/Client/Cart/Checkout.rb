require_relative '../../HelperLib/Helper.rb'

module Client
  class Checkout
    def initialize(session_object_in)
      @db = session_object_in
      Helper.clear
      execute
    end

    private
    # Helper Functions
    def checkout
      Helper.clear
      puts "\nProceeding To Checkout ....\n"
      puts "\nCheckout Complete, your order number is ###....\n"
      Helper.wait
    end

    #Main Method
    def execute
      puts "In Orders Execute"
      checkout
      Helper.wait
    end 
  end
end