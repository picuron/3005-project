require_relative '../../HelperLib/Helper.rb'
require_relative '../../Database/ClientQueries/LoginRegisterQueries.rb'

module Client
  class LoginRegister
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
    end

    def fetch_user(username, password)
      con = @session.db_connection_open
      user = LoginRegisterQueries.new(con).fetch_user(username, password)
      @session.db_connection_close(con)
      return user
    end

    def login
      while true
        Helper.clear
        puts "Username: "
        username = gets.chomp
        puts "Password: "
        password = gets.chomp
        fetched_user = fetch_user(username, password)
        if fetched_user.values.length != 0
          Helper.clear
          puts "Welcome #{username}"
          @user = fetched_user.values[0][0]
          break
        else
          Helper.clear
          puts "Incorrect username or Password"
          puts "[1] - Try again"
          puts "[2] - Quit"
          input = gets.chomp
          case input
          when "1"
            #loop
          when "2"
            Helper.clear
            break
          else
            Helper.invalid_entry_display
          end
        end
      end
      return @user
    end

    def register
    end
  end
end