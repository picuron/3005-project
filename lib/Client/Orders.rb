require_relative '../HelperLib/Helper.rb'

module Client
  class Orders
    attr_accessor :cart
    attr_accessor :session
    attr_accessor :user
    attr_accessor :state
    def initialize(session, cart, user)
      @session = session
      @cart = cart
      @user = user
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
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
      #updates the state as we exit file
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
    end
  end
end