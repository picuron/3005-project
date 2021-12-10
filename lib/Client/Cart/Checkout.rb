require_relative '../../HelperLib/Helper.rb'
require_relative './LoginRegister.rb'
require_relative '../../Database/ClientQueries/CheckoutQueries.rb'

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

    def get_addr_hash(addr_type)
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

    def checkout_user_and_cart(date_hash, shipping_hash = nil, billing_hash = nil)
      con = @session.db_connection_open
      success = CheckoutQueries.new(con).generate_checkout_success?(date_hash, @user, @cart, shipping_hash, billing_hash)
      @session.db_connection_close(con)
      if success
        puts "Return to Menu to View your Orders"
        @cart = nil
      end
    end

    def get_date_hash
      date = {}
      Helper.clear
      puts "We were silly, and designed this whole things without using Date objects, but now it is too late, so..."
      while true
        puts "Day (1 -> 31): "
        date["day"] = gets.chomp.to_i
        if date["day"] < 1 || date["day"] > 31
          puts "Invalid day, try again."
        else
          break
        end
      end
      while true
        puts "Month (1 -> 12): "
        date["month"] = gets.chomp.to_i
        if date["month"] < 1 || date["month"]> 12
          puts "Invalid Month, Try Again."
        else
          break
        end
      end
      while true
        puts "Year: "
        date["year"] = gets.chomp.to_i
        if date["year"] < 1500 || date["year"] > 2022
          puts "Invalid Year, Try Again."
        else
          break
        end
      end
      return date
    end

    def launch_checkout
      while true
        puts "\n Will your billling / shipping address be the same as your registered address?"
        puts "[1] - Yes \n[2] - No"
        input = gets.chomp
        case input
          when '1'
            #generates a checkout object
            date_hash = get_date_hash
            checkout_user_and_cart(date_hash)
            break
          when '2'
            billing_hash = get_billing_info
            shipping_hash = nil
            while true
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
                  break
                when '2'
                  shipping_hash = get_shipping_hash
                  break
                else
                  Helper.invalid_entry_display
              end
            end
            #this time provide alternate hashes
            date_hash = get_date_hash
            checkout_user_and_cart(date_hash, shipping_hash, billing_hash)
            break
          else
            Helper.invalid_entry_display
        end
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