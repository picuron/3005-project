require_relative '../../HelperLib/Helper.rb'
require_relative './LoginRegister.rb'

module Client
  class Checkout
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
      execute
    end

    def checkout_menu_display
      puts "There are items in your cart, but looks like you are not logged in right now..."
      puts "Would you like to..."
      puts "[0] - Login to an existing account"
      puts "[1] - Register a new account"
      puts "[2] - Go back to cart menu"
    end

    def fetch_cart(cart_id)
      con = @session.db_connection_open
      cart = CartQueries.new(con).my_cart(cart_id)
      @session.db_connection_close(con)
      return cart
    end

    def get_addr_info(addr_type)
      puts "#{addr_type} street number: "
      street_number = gets.chomp
      puts "#{addr_type} street name: "
      street_name =  gets.chomp
      puts "#{addr_type} postal code: "
      postal_code = gets.chomp
      puts "#{addr_type} city: "
      city = gets.chomp
      puts "#{addr_type} country: "
      country = gets.chomp

      return hash = {
        "#{addr_type}_street_number" => street_number,
        "#{addr_type}_street_name" => street_name,
        "#{addr_type}_postal_code" => postal_code,
        "#{addr_type}_city" => city,
        "#{addr_type}_country" => country
      }
    end

    def get_billing_info
      get_addr_hash("Billing")
    end

    def get_shipping_info
      get_addr_hash("Shipping")
    end

    def launch_checkout
      puts "\n Will your billling / shipping address be the same as your registered address?"
      puts "[1] - Yes \n[2] - No"
      input gets.chomp
      case input
      when '1'

      when '2'
        billing_hash = get_billing_info
        shipping_hash = nil
        puts "Is your Shipping Address the Same as Your Billing Address ?"
        puts "[1] - Yes\n[2] - No"
        same = gets.chomp
        case same
        when '1'
          shipping_hash = {
            "shipping_street_number" =>  billing_hash["billing_street_number"],
            "shipping_street_name" => billing_hash["billing_street_name"],
            "shipping_postal_code" => billing_hash["billing_postal_code"],
            "shipping_city" => billing_hash["billing_city"],
            "shipping_country" => billing_hash["billing_country"]
          }
        when '2'
          shipping_hash = get_shipping_hash
        else
          Helper.invalid_entry_display
        end
      else
        Helper.invalid_entry_display
      end
    end

    private
    # Helper Functions
    def checkout_controller
      while true
        case fetch_cart(@cart).values.length
          when 0
            puts "Cannot perform Checkout on Empty Cart"
            Helper.wait
            break
          else
            case @user
              when nil
                checkout_menu_display
                input = gets.chomp
                case input
                  when '0'
                    @user = LoginRegister.new(@session, @cart, @user).login
                  when '1'
                    @user = LoginRegister.new(@session, @cart, @user).register
                  when '2'
                    break
                  else
                    Helper.invalid_entry_display
                  end
              else
                puts "launching checkout with your credentials..."
                launch_checkout
                Helper.wait
            end
        end
      end
    end

    #Main Method
    def execute
      checkout_controller
      #updates the state as we exit file
      @state = {"session" => @session, "cart" => @cart, "user" => @user}
    end
  end
end